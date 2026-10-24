#!/usr/bin/env python3
"""Check real TUI startup and Tokyo Night rendering without playing audio."""

import errno
import fcntl
import os
from pathlib import Path
import pty
import select
import shutil
import signal
import struct
import subprocess
import sys
import tempfile
import termios
import time


def main():
    binary = shutil.which(sys.argv[1] if len(sys.argv) > 1 else "cliamp")
    if binary is None:
        raise SystemExit("Missing test dependency: cliamp (or supply its path)")
    feature = Path(__file__).resolve().parents[1]
    with tempfile.TemporaryDirectory(prefix="cliamp-runtime-") as temporary:
        home = Path(temporary)
        env = dict(os.environ)
        env.pop("CLIAMP_CONFIG_DIR", None)
        env.update(
            HOME=str(home),
            XDG_CONFIG_HOME=str(home / ".config"),
            XDG_DATA_HOME=str(home / ".local/share"),
            XDG_CACHE_HOME=str(home / ".cache"),
            XDG_STATE_HOME=str(home / ".local/state"),
            XDG_RUNTIME_DIR=str(home / "run"),
            TERM="xterm-256color",
            COLORTERM="truecolor",
        )
        env.pop("NO_COLOR", None)
        (home / "run").mkdir(mode=0o700)
        config = home / ".config/cliamp/config.toml"
        config.parent.mkdir(parents=True)
        config.write_text(
            'theme = "gruvbox" # Preserve this comment\nvolume = -12\n',
            encoding="ascii",
        )
        if sys.platform.startswith("linux"):
            alsa_config = home / "alsa-test.conf"
            alsa_config.write_text('pcm.!default { type null }\n', encoding="ascii")
            env["ALSA_CONFIG_PATH"] = str(alsa_config)
            print("Runtime fixture: ALSA null device (not an audible playback test)")
        subprocess.run(
            [str(feature / "configure.sh"), str(home)],
            env=env,
            check=True,
            stdout=subprocess.DEVNULL,
        )
        subprocess.run([binary, "--version"], env=env, check=True)
        subprocess.run(
            [binary, "--help"], env=env, check=True, stdout=subprocess.DEVNULL
        )
        pid, master = pty.fork()
        if pid == 0:
            os.execve(binary, [binary], env)
        output = bytearray()
        colors = (b"38;2;122;162;247", b"38;2;207;201;194")
        reaped = False
        try:
            fcntl.ioctl(
                master, termios.TIOCSWINSZ, struct.pack("HHHH", 40, 120, 0, 0)
            )
            deadline = time.monotonic() + 20
            while time.monotonic() < deadline:
                if select.select([master], [], [], 0.1)[0]:
                    try:
                        chunk = os.read(master, 65536)
                    except OSError as error:
                        if error.errno != errno.EIO:
                            raise
                        break
                    if not chunk:
                        break
                    output.extend(chunk)
                    # Reply to terminal queries so startup does not wait for them.
                    if b"\x1b[6n" in chunk:
                        os.write(master, b"\x1b[1;1R")
                    if b"\x1b]11;" in chunk:
                        os.write(master, b"\x1b]11;rgb:1a1a/1b1b/2626\x1b\\")
                    if all(color in output for color in colors):
                        break
                ended, _ = os.waitpid(pid, os.WNOHANG)
                if ended:
                    reaped = True
                    break
            if not all(color in output for color in colors):
                raise AssertionError(
                    "TUI did not render Tokyo Night colors (#7aa2f7, #cfc9c2): "
                    + repr(bytes(output[-2000:]))
                )
            if reaped or os.waitpid(pid, os.WNOHANG)[0]:
                reaped = True
                raise AssertionError("TUI exited during startup")
            os.write(master, b"\x03")
            print("PASS: real cliamp TUI startup and Tokyo Night truecolor rendering")
        finally:
            if not reaped:
                deadline = time.monotonic() + 3
                while time.monotonic() < deadline:
                    if os.waitpid(pid, os.WNOHANG)[0]:
                        reaped = True
                        break
                    time.sleep(0.05)
                if not reaped:
                    os.kill(pid, signal.SIGKILL)
                    os.waitpid(pid, 0)
            os.close(master)


if __name__ == "__main__":
    main()
