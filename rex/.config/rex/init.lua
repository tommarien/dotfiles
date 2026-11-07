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

local terminal = "com.superlogical.terminal"

local function foreground(ctx)
  local result = rex.block.call(terminal, "process", { block_id = ctx.block_id })
  return result and (result.foreground or (result.ancestors or {})[1])
end

-- the focused pane's directory, from what the shell last reported or else its foreground process
local function focused_cwd(ctx)
  local pwd = rex.block.call(terminal, "pwd", { block_id = ctx.block_id })
  if pwd and pwd.pwd then
    return (pwd.pwd:gsub("^file://[^/]*", ""))
  end
  local proc = foreground(ctx)
  return proc and proc.cwd
end

local path = "/opt/homebrew/bin:" ..
    os.getenv("HOME") ..
    "/Library/Application Support/com.superlogical.rex/RexServer/Versions/Current/Rex Server.app/Contents/MacOS:" ..
    os.getenv("PATH")
local path_env = "PATH=" .. path

-- a palette action that opens a floating pane in the focused pane's directory, running command
local function float(spec)
  rex.action {
    name = spec.name,
    title = spec.title,
    keywords = spec.keywords,
    run = function(ctx)
      local command = { "/usr/bin/env", path_env }
      for _, arg in ipairs(spec.command) do command[#command + 1] = arg end
      local layer, err = rex.session.new_layer {
        bounds = spec.bounds or { x = 0.15, y = 0.15, w = 0.7, h = 0.7 },
        focus = true,
        layout = rex.layout.block {
          flavor = terminal .. ".shell",
          options = { command = command, cwd = focused_cwd(ctx) },
        },
      }
      if err ~= nil then error(err, 0) end
      rex.session.focus_block { block_id = layer.block_ids[1] }
    end,
  }
end

local sessionizer = os.getenv("HOME") .. "/bin/scripts/rex-sessionizer"

float { name = "sessionizer", title = "Sessionizer", keywords = "project session open", command = { sessionizer } }
-- no fzf needed, so run headless instead of in a floating pane
rex.action {
  name = "sessionizer_dotfiles",
  title = "Sessionizer: dotfiles",
  keywords = "dotfiles session open",
  run = function(ctx)
    local result, err = rex.exec(
      { sessionizer, os.getenv("HOME") .. "/dotfiles" },
      { env = { PATH = path, REX_SESSION = ctx.session_id } }
    )
    if err ~= nil then error(err, 0) end
    if not result.ok then error(result.stderr, 0) end
  end,
}
float {
  name = "new_worktree",
  title = "New Worktree",
  keywords = "worktree branch gtr",
  command = { os.getenv("HOME") .. "/bin/scripts/rex-worktree-new" },
  bounds = { x = 0.3, y = 0.4, w = 0.4, h = 0.2 },
}
float {
  name = "close_session",
  title = "Close Session",
  keywords = "session kill close",
  command = { os.getenv("HOME") .. "/bin/scripts/rex-session-close" },
}
float {
  name = "lazygit",
  title = "Lazygit",
  keywords = "git lazygit float",
  command = { "lazygit" },
  bounds = { x = 0.01, y = 0.01, w = 0.98, h = 0.98 },
}

rex.bind("ctrl+a>f", "sessionizer")
rex.bind("ctrl+a>shift+d", "sessionizer_dotfiles")
rex.bind("ctrl+a>g", "lazygit")
rex.bind("ctrl+a>w", "new_worktree")
rex.bind("ctrl+a>shift+x", "close_session")
