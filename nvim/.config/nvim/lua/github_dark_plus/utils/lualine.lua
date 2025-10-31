return function()
    local c = require('github_dark_plus.palette')
    local theme = {}

    theme.normal = {
        a = { bg = c.blue, fg = c.bg, gui = "bold" },
        b = { bg = c.bg_darker, fg = c.fg },
        c = { bg = c.bg_darker, fg = c.fg_dim },
    }

    theme.insert = {
        a = { bg = c.green_light, fg = c.bg, gui = "bold" },
        b = { bg = c.bg_darker, fg = c.fg },
    }

    theme.terminal = {
        a = { bg = c.blue, fg = c.bg, gui = "bold" },
        b = { bg = c.bg_darker, fg = c.fg },
    }

    theme.command = {
        a = { bg = c.yellow, fg = c.bg, gui = "bold" },
        b = { bg = c.bg_darker, fg = c.fg },
    }

    theme.visual = {
        a = { bg = c.purple_light, fg = c.bg, gui = "bold" },
        b = { bg = c.bg_darker, fg = c.fg },
    }

    theme.replace = {
        a = { bg = c.cyan, fg = c.bg, gui = "bold" },
        b = { bg = c.bg_darker, fg = c.fg },
    }

    theme.inactive = {
        a = { bg = c.bg, fg = c.blue },
        b = { bg = c.bg, fg = c.fg, gui = "bold" },
        c = { bg = c.bf, fg = c.fg },
    }

    return theme
end
