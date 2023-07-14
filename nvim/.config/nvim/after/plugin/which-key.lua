local wk = require 'which-key'

wk.setup({})

local harpoonMap = {
    name = 'Harpoon',
    s = { function() require("harpoon.ui").toggle_quick_menu() end, "Show menu" },
    a = { function() require("harpoon.mark").add_file() end, "Add mark" },
}

for i = 1, 4 do
    harpoonMap[tostring(i)] = { function() require("harpoon.ui").nav_file(i) end, "Navigate to mark " .. i }
end

wk.register({
    b = {
        name = "Buffer",
        d = { "<cmd>bd<cr>", "Delete buffer" },
        n = { "<cmd>bn<cr>", "Next buffer" },
        p = { "<cmd>bp<cr>", "Previous buffer" },
        r = { "<cmd>Telescope buffers<cr>", "Open recent buffer" },
        s = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Search buffer" },
    },
    f = {
        name = "File",
        b = { "<cmd>Telescope buffers<cr>", "Open buffers" },
        d = { "<cmd>Telescope diagnostics<cr>", "Search diagnostics" },
        f = { "<cmd>Telescope find_files<cr>", "Find file" },
        r = { "<cmd>Telescope oldfiles<cr>", "Open recent file" },
        s = { "<cmd>Telescope live_grep_args<cr>", "Search string" },
    },
    h = harpoonMap,
    p = {
        name = 'PackageInfo',
        s = { function() require("package-info").show() end, "Show dependency versions" },
        c = { function() require("package-info").hide() end, "Hide dependency versions" },
        t = { function() require("package-info").toggle() end, "Toggle dependency versions" },
        u = { function() require("package-info").update() end, "Update dependency on the line" },
        d = { function() require("package-info").delete() end, "Delete dependency on the line" },
        i = { function() require("package-info").install() end, "Install a new dependency" },
        p = { function() require("package-info").change_version() end, "Install a different version" },
    },
    c = {
        name = 'Crates',
        t = { function() require("crates").toggle() end, "Toggle" },
        r = { function() require("crates").reload() end, "Reload" },
        v = { function() require("crates").show_versions_popup() end, "Show versions" },
        f = { function() require("crates").show_features_popup() end, "Show features" },
        d = { function() require("crates").show_dependencies_popup() end, "Show dependencies" },
        s = { function() require("crates").focus_popup() end, "Focus popup" },
        a = { function() require("crates").update_all_crates() end, "Update all crates" },
        u = { function() require("crates").update_crate() end, "Update crate" },
        A = { function() require("crates").upgrade_all_crates() end, "Upgrade all crates" },
        U = { function() require("crates").upgrade_crate() end, "Upgrade crate" },
    }
}, { prefix = "<leader>" })

wk.register({
    B = { "<cmd>bfirst<cr>", "First buffer" },
    b = { "<cmd>bprev<cr>", "Previous buffer" },
    h = { function() require("harpoon.ui").nav_prev() end, "Previous harpoon mark" },
}, { prefix = "[" })

wk.register({
    B = { "<cmd>blast<cr>", "Last buffer" },
    b = { "<cmd>bnext<cr>", "Next buffer" },
    h = { function() require("harpoon.ui").nav_next() end, "Next harpoon mark" },
}, { prefix = "]" })