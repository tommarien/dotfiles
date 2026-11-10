local function set_js_test_runner()
    vim.ui.input(
        { prompt = 'Enter JS test runner (e.g., jest): ' },
        function(input)
            if input and input ~= '' then
                vim.g['test#javascript#runner'] = input
                vim.notify('Set JS test runner to: ' .. input, vim.log.levels.INFO)
            else
                vim.notify('No runner set.', vim.log.levels.WARN)
            end
        end)
end

local function rex(args)
    local res = vim.system(vim.list_extend({ 'rex' }, args), { text = true }):wait()
    if res.code ~= 0 then
        vim.notify('rex: ' .. (res.stderr or ''), vim.log.levels.ERROR)
        return nil
    end
    return res.stdout
end

-- hooks: optional shell snippets run at start, on pass and on fail
local function with_status(cmd, hooks)
    hooks = hooks or {}
    return ('%s; %s && { %s; } || { %s; }'):format(hooks.start or ':', cmd, hooks.pass or ':', hooks.fail or ':')
end

local function rex_tab(cmd)
    rex({
        'run', '-s', vim.env.REX_SESSION, '-c', vim.fn.getcwd(),
        '--label', 'Tests', '--keep-open', '--', 'sh', '-c', with_status(cmd),
    })
end

-- the reusable test float of this tab: a floating layer holding a block labelled "Tests…".
-- Found again after nvim restarts; floats belong to a window, so only nvim's own window is searched.
local function find_float()
    local out = rex({ 'session', 'inspect', vim.env.REX_SESSION, '--json' })
    if not out then return end
    for _, window in ipairs(vim.json.decode(out).windows) do
        local mine = false
        for _, layer in ipairs(window.layers) do
            for _, block in ipairs(layer.blocks or {}) do
                mine = mine or block.block_id == vim.env.REX_BLOCK
            end
        end
        for _, layer in ipairs(mine and window.layers or {}) do
            if layer.kind ~= 'tiled' then
                for _, block in ipairs(layer.blocks or {}) do
                    if vim.startswith(block.label or '', 'Tests') then
                        return { block_id = block.block_id, layer_id = layer.layer_id }
                    end
                end
            end
        end
    end
end

local function alive(pane)
    local out = pane and rex({ 'block', 'ls', '-s', vim.env.REX_SESSION, '--json' })
    return out and out:find(pane.block_id, 1, true) ~= nil
end

local function send(block_id, cmd, hooks)
    rex({ 'send', '-s', vim.env.REX_SESSION, '-b', block_id, ('clear; cd %s && %s\n'):format(
        vim.fn.shellescape(vim.fn.getcwd()), with_status(cmd, hooks)) })
end

local function rex_float(cmd)
    local session = vim.env.REX_SESSION
    local float = find_float()
    local reuse = float ~= nil
    if not reuse then
        local out = rex({
            'split', '-s', session, '-b', vim.env.REX_BLOCK, '--split=below',
            '-c', vim.fn.getcwd(), '--label', 'Tests', '--focus=false', '--json',
        })
        if not out then return end
        local block_id = vim.json.decode(out).block_ids[1]
        local res = rex({
            'api', 'call', '-s', session, 'session.float_block',
            vim.json.encode({ block_id = block_id, bounds = { 0.1, 0.1, 0.8, 0.8 } }),
        })
        if not res then return end
        float = { block_id = block_id, layer_id = vim.json.decode(res).layer_id }
        rex({
            'api', 'call', '-s', session, 'session.set_layer_state',
            vim.json.encode({ layer_id = float.layer_id, state = 'normal', focus = true }),
        })
    end
    if reuse then
        rex({ 'send', '-s', session, '-b', float.block_id, '\003' }) -- stop a previous run
    end
    -- the float title shows the outcome; a failure also brings the float back if it was minimized
    local function shell_api(method, args)
        return ('rex api call -s %s %s %s >/dev/null'):format(session, method, vim.fn.shellescape(vim.json.encode(args)))
    end
    local function label(text)
        return shell_api('session.set_block_label', { block_id = float.block_id, label = text })
    end
    send(float.block_id, cmd, {
        start = label('Tests …'),
        pass = label('Tests ✓'),
        fail = label('Tests ✗') .. '; ' .. shell_api('session.set_layer_state',
            { layer_id = float.layer_id, state = 'normal', focus = true }),
    })
end

local split -- { block_id } of the reusable test split

local function rex_split(cmd)
    local session = vim.env.REX_SESSION
    local reuse = alive(split)
    if not reuse then
        local out = rex({
            'split', '-s', session, '-b', vim.env.REX_BLOCK, '--split=below',
            '-c', vim.fn.getcwd(), '--label', 'Tests', '--focus=false', '--json',
        })
        if not out then return end
        split = { block_id = vim.json.decode(out).block_ids[1] }
        -- `split --ratio` is ignored (stays 50/50), so resize the border explicitly
        rex({
            'api', 'call', '-s', session, 'session.resize_pane',
            vim.json.encode({
                before_block_id = vim.env.REX_BLOCK,
                after_block_id = split.block_id,
                direction =
                'vertical',
                ratio = 0.8
            }),
        })
    else
        rex({ 'send', '-s', session, '-b', split.block_id, '\003' }) -- stop a previous run
    end
    send(split.block_id, cmd)
end

return {
    {
        'vim-test/vim-test',
        event = 'VeryLazy',
        enabled = vim.env.KITTY_SCROLLBACK_NVIM ~= 'true',
        keys = {
            { '<leader>tt', vim.cmd.TestNearest, desc = 'Run Nearest Test' },
            { '<leader>tf', vim.cmd.TestFile,    desc = 'Run Test File' },
            { '<leader>ts', vim.cmd.TestSuite,   desc = 'Run All Test Files' },
            { '<leader>tr', vim.cmd.TestLast,    desc = 'Run Last Test Run' },
            { '<leader>tj', set_js_test_runner,  desc = 'Set JS Test Runner' }
        },
        config = function()
            vim.g['test#custom_strategies'] = { rex_tab = rex_tab, rex_float = rex_float, rex_split = rex_split }
            vim.g['test#strategy'] = 'rex_float' -- or 'rex_float', 'rex_tab'
        end
    }
}
