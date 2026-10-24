#!/usr/bin/env python3
"""Bounded terminal smoke tests using an isolated home supplied by run.sh."""

import errno
import fcntl
import os
from pathlib import Path
import pty
import re
import select
import shlex
import signal
import struct
import sys
import termios
import time


def diagnostic(output):
    return re.sub(r"\x1b\[[0-?]*[ -/]*[@-~]", "", output.decode(errors="replace"))[-2500:]


def terminal_run(argv, ready, keys, expected_status=0, followup=None):
    pid, master = pty.fork()
    if pid == 0:
        os.execvp(argv[0], argv)
    fcntl.ioctl(master, termios.TIOCSWINSZ, struct.pack("HHHH", 40, 140, 0, 0))
    output = bytearray()
    deadline = time.monotonic() + 20
    sent = False
    cursor_replies = 0
    followup_at = None
    reaped = False
    try:
        while time.monotonic() < deadline:
            if select.select([master], [], [], 0.1)[0]:
                try:
                    chunk = os.read(master, 65536)
                except OSError as error:
                    if error.errno != errno.EIO:
                        raise
                    chunk = b""
                output.extend(chunk)
            cursor_requests = output.count(b"\x1b[6n")
            if cursor_requests > cursor_replies:
                os.write(master, b"\x1b[1;1R" * (cursor_requests - cursor_replies))
                cursor_replies = cursor_requests
            if not sent and ready(output):
                os.write(master, keys)
                sent = True
                if followup is not None:
                    followup_at = time.monotonic() + 0.5
            if followup_at is not None and time.monotonic() >= followup_at:
                os.write(master, followup)
                followup_at = None
            exited, status = os.waitpid(pid, os.WNOHANG)
            if exited:
                reaped = True
                assert sent, f"UI not ready: {argv}\n{diagnostic(output)}"
                assert os.waitstatus_to_exitcode(status) == expected_status, (
                    argv, status, diagnostic(output)
                )
                return output
        raise AssertionError(f"Terminal timeout: {argv}\n{diagnostic(output)}")
    finally:
        if not reaped:
            os.kill(pid, signal.SIGKILL)
            os.waitpid(pid, 0)
        os.close(master)


if sys.argv[1] == "--shell":
    shell = sys.argv[2]
    flags = ["--noprofile", "--norc"] if shell == "bash" else ["-df"]
    output = terminal_run(
        [shell, *flags, "-ic", '. "$1"', shell, sys.argv[3]],
        lambda output: b"PASS: shell integration" in output,
        b"",
    )
    print(output.decode(errors="replace"))
    sys.exit(0)

os.chdir(sys.argv[1])
filename = "-quote' $(touch INJECTION); file.txt"
Path(filename).write_text("PREVIEW_SENTINEL\n")
for shell, flags in (("bash", ["--noprofile", "--norc"]), ("zsh", ["-df"])):
    script = '. "$FEATURE/config/.my-shell-conf/confs/generic/fzf.sh"; ff'
    env_command = f"printf '%s\\n' {shlex.quote(filename)}"
    os.environ["FZF_DEFAULT_COMMAND"] = env_command
    terminal_run(
        [shell, *flags, "-c", script],
        lambda output: b"PREVIEW_SENTINEL" in output,
        b"\r",
    )
    assert not Path("INJECTION").exists(), "preview interpreted filename as shell code"
    terminal_run(
        [shell, *flags, "-c", script],
        lambda output: b"PREVIEW_SENTINEL" in output,
        b"\x03",
        expected_status=130,
    )
os.environ.pop("FZF_DEFAULT_COMMAND")
terminal_run(
    ["lazygit"],
    lambda output: "getstarted" in "".join(diagnostic(output).lower().split()),
    b"\r",
    followup=b"q",
)
review_file = Path("hunk-review.txt")
review_file.write_text("HUNK_WATCH_BEFORE\n")
terminal_run(
    ["hunk", "diff"],
    lambda output: b"HUNK_WATCH_BEFORE" in output,
    b"q",
)
watch_changed = False


def hunk_watch_ready(output):
    global watch_changed
    if not watch_changed and b"HUNK_WATCH_BEFORE" in output:
        review_file.write_text("HUNK_WATCH_AFTER\n")
        watch_changed = True
    return b"HUNK_WATCH_AFTER" in output


terminal_run(["hunk", "diff", "--watch"], hunk_watch_ready, b"q")
terminal_run(
    ["btop", "--force-utf"],
    lambda output: b"cpu" in output.lower() and b"proc" in output.lower(),
    b"q",
)
terminal_run(
    ["dua", "interactive", "."],
    lambda output: b"visible.txt" in output,
    b"q",
)
print("PASS: real ff previews/cancellation, Hunk diff/watch updates, and lazygit/btop/dua startup")
