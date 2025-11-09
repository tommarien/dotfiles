--- @class BrightColor
--- @field base string
--- @field bright string

--- @class DimColor
--- @field base string
--- @field dim string

--- @class BrightDimColor
--- @field base string
--- @field bright string
--- @field dim string

--- @class UI
--- @field border string
--- @field selection string
--- @field search string
--- @field visual string
--- @field comment string
--- @field operator string

--- @class GithubDarkMin.Palette
--- @field bg BrightDimColor
--- @field fg DimColor
--- @field black BrightColor
--- @field red BrightColor
--- @field green BrightColor
--- @field yellow BrightColor
--- @field orange BrightColor
--- @field blue BrightColor
--- @field purple BrightColor
--- @field cyan BrightColor
--- @field white BrightColor
--- @field pink BrightColor
--- @field none string
--- @field diagnostics { hint: string, info: string, warn:string, error: string }
--- @field git { add:string, change:string, delete:string }
--- @field diff { add:string, change:string, delete:string, text:string }
--- @field ui UI
local p = {
    black  = { base = '#22272e', bright = '#768390' },
    red    = { base = '#f47067', bright = '#ff938a' },
    green  = { base = '#57ab5a', bright = '#9edb8c' },
    yellow = { base = '#daaa3f', bright = '#f2cc60' },
    orange = { base = '#f69d50', bright = '#ffb86b' },
    blue   = { base = '#539bf5', bright = '#79c0ff' },
    purple = { base = '#b083f0', bright = '#d2a8ff' },
    cyan   = { base = '#96d0ff', bright = '#a5d6ff' },
    white  = { base = '#d1d7e0', bright = '#fbffff' },
    pink   = { base = '#e275ad', bright = '#ffb3d8' },
    none   = 'NONE'
}

p.bg = { base = p.black.base, bright = '#2d333b', dim = '#1c2128' }
p.fg = { base = p.white.base, dim = p.black.bright }

p.diagnostics = {
    hint = p.black.bright,
    info = p.blue.base,
    warn = p.yellow.base,
    error = '#e5534b'
}

p.git = {
    add = p.green.base,
    change = p.yellow.base,
    delete = p.red.base,
}

p.ui = {
    border    = '#444c56',
    selection = '#3c444d',
    search    = '#496380',
    visual    = '#3c444d',
    comment   = '#9098a1',
    operator  = '#9bb4bc',
}

p.diff = {
    add = '#2f4839',
    change = '#29384c',
    delete = '#57393c',
    text = p.ui.search
}

return p
