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
  f = {
    name = "File",
    b = { "<cmd>Telescope buffers<cr>", "Open buffers" },
    d = { "<cmd>Telescope diagnostics<cr>", "Search diagnostics" },
    f = { "<cmd>Telescope find_files<cr>", "Find file" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open recent file" },
    s = { "<cmd>Telescope live_grep_args<cr>", "Search string" },
    w = { "<cmd>Telescope grep_string<cr>", "Search word under cursor" },
  },
  h = harpoonMap,
  n = {
    name = 'PackageInfo',
    s = { function() require("package-info").show() end, "Show dependency versions" },
    c = { function() require("package-info").hide() end, "Hide dependency versions" },
    t = { function() require("package-info").toggle() end, "Toggle dependency versions" },
    u = { function() require("package-info").update() end, "Update dependency on the line" },
    d = { function() require("package-info").delete() end, "Delete dependency on the line" },
    i = { function() require("package-info").install() end, "Install a new dependency" },
    p = { function() require("package-info").change_version() end, "Install a different version" },
  },
}, { prefix = "<leader>" })

local windowMap = {
  name = 'Window',
}

for i = 1, 6 do
  ---@diagnostic disable-next-line: assign-type-mismatch
  windowMap[tostring(i)] = { i .. "<C-w><C-w>", "Navigate to window " .. i }
end

wk.register(windowMap, { prefix = "<leader>" })

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