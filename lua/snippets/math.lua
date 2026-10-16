-- Math-mode snippets shared by luasnippets/tex.lua and luasnippets/markdown.lua.
-- Usage: vim.list_extend(snippets, require('snippets.math')(in_math))
local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local rep = require('luasnip.extras').rep
local fmta = require('luasnip.extras.fmt').fmta

return function(in_math)
    -- Autosnippet that only fires inside math
    local function auto(trig, nodes, opts)
        opts = opts or {}
        opts.trig = trig
        opts.snippetType = 'autosnippet'
        opts.condition = in_math
        return s(opts, nodes)
    end

    local function capture(n)
        return f(function(_, snip) return snip.captures[n] end)
    end

    local snippets = {
        -- Environments
        auto('beg', fmta([[
            \begin{<>}
                <>
            \end{<>}
        ]], { i(1), i(0), rep(1) })),
        auto('ali', fmta([[
            \begin{aligned}
                <>
            \end{aligned}
        ]], { i(1) })),
        -- 2-3mat -> 2x3 matrix; type the matrix kind (p, b, v...) in the first slot
        auto('(%d+)-(%d+)mat', fmta([[
            \begin{<>matrix}
            <>
            \end{<>matrix}
        ]], {
            i(1),
            d(2, function(_, snip)
                local rows, cols = tonumber(snip.captures[1]), tonumber(snip.captures[2])
                local nodes, idx = {}, 1
                for r = 1, rows do
                    for c = 1, cols do
                        table.insert(nodes, i(idx, tostring(idx)))
                        if c < cols then table.insert(nodes, t(' & ')) end
                        idx = idx + 1
                    end
                    if r < rows then table.insert(nodes, t({ ' \\\\', '' })) end
                end
                return sn(nil, nodes)
            end),
            rep(1),
        }), { regTrig = true }),

        -- Fractions, roots, derivatives, functions
        auto('frac', fmta('\\frac{<>}{<>}', { i(1), i(2) })),
        auto('sqrt', fmta('\\sqrt{<>}', { i(1) })),
        auto('diff', fmta('\\frac{d <>}{d <>}', { i(1), i(2) })),
        auto('partial', fmta('\\frac{\\partial <>}{\\partial <>}', { i(1), i(2) })),
        auto('sin', fmta('\\sin(<>)', { i(1) })),
        auto('cos', fmta('\\cos(<>)', { i(1) })),
        auto('tan', fmta('\\tan(<>)', { i(1) })),

        -- Fonts and custom notation
        auto('cal', fmta('\\mathcal{<>}', { i(1) })),
        auto('bold', fmta('\\mathbf{<>}', { i(1) })),
        auto('sbold', fmta('\\boldsymbol{<>}', { i(1) })),
        auto('skew', fmta('\\left[ <> \\right]_{\\times}', { i(1) })),
        auto('clamp', fmta('\\left <> <> \\right <>', { i(1), i(3), i(2) })),
        auto('frame', fmta('\\mathscr{F}_{<>}', { i(1) })),
        auto('adjo', fmta('\\text{Ad}_{<>}(<>)', { i(1), i(2) })),
        auto('madjo', fmta('\\textbf{Ad}_{<>}', { i(1) })),
        auto(' *', t('\\cdot '), { wordTrig = false }),

        -- Sub- and superscripts: x1 -> x_1, then a second digit -> x_{12}
        auto('([a-zA-Z])(%d)', fmta('<>_<>', { capture(1), capture(2) }),
            { regTrig = true, wordTrig = false }),
        auto('([a-zA-Z])_(%d)(%d)', fmta('<>_{<><><>}', { capture(1), capture(2), capture(3), i(1) }),
            { regTrig = true, wordTrig = false }),
        auto('_', fmta('_{<>}', { i(1) }), { wordTrig = false }),
        auto('^', fmta('^{<>}', { i(1) }), { wordTrig = false }),
    }

    -- Plain replacements
    local symbols = {
        alph = '\\alpha', bet = '\\beta', delt = '\\delta',
        eps = '\\epsilon', veps = '\\varepsilon', thet = '\\theta',
        rho = '\\rho', tau = '\\tau', phi = '\\phi', vphi = '\\varphi',
        psi = '\\psi', omega = '\\omega',
        vec = '\\vec ', dot = '\\dot ', ddot = '\\ddot ',
        quad = '\\quad', qquad = '\\qquad', real = '\\mathbb{R}',
    }
    for trig, text in pairs(symbols) do
        table.insert(snippets, auto(trig, t(text)))
    end

    return snippets
end
