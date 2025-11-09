return {
    "folke/snacks.nvim",
    opts = {
        notifier = { enabled = true },

        -- show hidden files in snacks.explorer
        picker = {
            sources = {
                explorer = {
                    hidden = true,
                    ignored = true,
                    exclude = { "node_modules", ".git" },
                },
                files = {
                    hidden = true,
                    ignored = true,
                },
            },
            hidden = true,
            ignored = true,
        },
    },
}
