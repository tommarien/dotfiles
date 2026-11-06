local amber = dofile(os.getenv("HOME") .. "/.local/share/rex/amber/amber.lua")

amber.setup({
  plugins = {
    { "rawnly/smart-splits-backend-rex", main = "smart-splits-rex", opts = { resize_amount = 3 } },
  },
})

-- Smartsplit setup
for key, direction in pairs({ h = 'left', j = 'down', k = 'up', l = 'right' }) do
  rex.bind('ctrl+' .. key, 'smart_splits_focus', { direction = direction, key = 'ctrl+' .. key })
  rex.bind('alt+' .. key, 'smart_splits_resize', { direction = direction, key = 'alt+' .. key })
end

rex.bind("cmd+r", "client.config.reload")
rex.bind("shift+enter", "pane.send_key", { key = "alt+enter" })
rex.bind("ctrl+a>shift+\\", "pane.split", { direction = "right" })
rex.bind("ctrl+a>-", "pane.split", { direction = "down" })
rex.bind("ctrl+a>x", "pane.close")
rex.bind("ctrl+a>m", "pane.zoom")
rex.bind("ctrl+a>s", "session.switch")
rex.bind("ctrl+a>c", "client.tab.new")
rex.bind("ctrl+a>n", "client.tab.next")
rex.bind("ctrl+a>p", "client.tab.previous")
rex.bind("ctrl+a>,", "client.tab.rename")
rex.bind("ctrl+a>shift+7", "client.tab.close")
rex.bind("ctrl+a>1", "client.tab.goto", { index = 1 })
rex.bind("ctrl+a>2", "client.tab.goto", { index = 2 })
rex.bind("ctrl+a>3", "client.tab.goto", { index = 3 })
rex.bind("ctrl+a>4", "client.tab.goto", { index = 4 })
rex.bind("ctrl+a>5", "client.tab.goto", { index = 5 })
rex.bind("ctrl+a>6", "client.tab.goto", { index = 6 })
rex.bind("ctrl+a>7", "client.tab.goto", { index = 7 })
rex.bind("ctrl+a>8", "client.tab.goto", { index = 8 })
rex.bind("ctrl+a>9", "client.tab.goto", { index = 9 })

local function overlay(program, args, bounds, cwd)
  local command = {
    "/usr/bin/env",
    "PATH=/opt/homebrew/bin:" ..
    os.getenv("HOME") ..
    "/Library/Application Support/com.superlogical.rex/RexServer/Versions/Current/Rex Server.app/Contents/MacOS:" ..
    os.getenv("PATH"),
    program,
  }
  if args then command[4] = args end
  local layer, err = rex.session.new_layer {
    bounds = bounds or { x = 0.15, y = 0.15, w = 0.7, h = 0.7 },
    focus = true,
    layout = rex.layout.block {
      flavor = "com.superlogical.terminal.shell",
      options = { command = command, cwd = cwd },
    },
  }
  if err ~= nil then error(err, 0) end
  rex.session.focus_block { block_id = layer.block_ids[1] }
end

local function sessionizer(args)
  return function() overlay(os.getenv("HOME") .. "/bin/scripts/rex-sessionizer", args) end
end

rex.action { name = "sessionizer", title = "Sessionizer", run = sessionizer() }
rex.action { name = "sessionizer_dotfiles", title = "Sessionizer: dotfiles", run = sessionizer(os.getenv("HOME") .. "/dotfiles") }

local function focused_cwd()
  local result = rex.block.call("com.superlogical.terminal", "process", {})
  local proc = result and (result.foreground or (result.ancestors or {})[1])
  return proc and proc.cwd
end

rex.action {
  name = "lazygit",
  title = "Lazygit",
  run = function() overlay("lazygit", nil, { x = 0.01, y = 0.01, w = 0.98, h = 0.98 }, focused_cwd()) end,
}

rex.bind("ctrl+a>f", "sessionizer")
rex.bind("ctrl+a>shift+d", "sessionizer_dotfiles")
rex.bind("ctrl+a>g", "lazygit")
