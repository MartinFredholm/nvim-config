local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local rep = require('luasnip.extras').rep
local fmta = require('luasnip.extras.fmt').fmta

local function in_math()
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
end
local function not_in_math()
    return not in_math()
end

local function auto(trig, nodes, opts)
    opts = opts or {}
    opts.trig = trig
    opts.snippetType = 'autosnippet'
    return s(opts, nodes)
end

local snippets = {
    -- Entering math
    auto('mk', fmta('$<>$', { i(1) }), { condition = not_in_math }),
    auto('dm', fmta([[
        \[
        <>
        \]
    ]], { i(1) }), { condition = not_in_math }),

    -- Auto-closing brackets: ( and { everywhere, [ only in math
    auto('(', { t('('), i(1), t(')') }, { wordTrig = false }),
    auto('{', fmta('{<>}', { i(1) }), { wordTrig = false }),
    auto('[', fmta('[<>]', { i(1) }), { wordTrig = false, condition = in_math }),

    -- Commands and environments
    auto('\\cite', fmta('(\\cite{<>}, p. <>)', { i(1), i(2) })),
    auto('\\eq', fmta([[
        \begin{equation}
            <>
        \end{equation}
    ]], { i(1) })),
    auto('\\ali', fmta([[
        \begin{align}
            <>
        \end{align}
    ]], { i(1) })),
    auto('\\beg', fmta([[
        \begin{<>}
            <>
        \end{<>}
    ]], { i(1), i(0), rep(1) })),
    auto('\\fig', fmta([[
        \begin{figure}
            \centering{
            <>
            }
            \caption{<>}
            \label{<>}
        \end{figure}
    ]], { i(1), i(2), i(3) })),
    auto('\\incg', fmta('\\includegraphics[width=<>\\textwidth]{<>}', { i(1), i(2) })),
}

vim.list_extend(snippets, require('snippets.math')(in_math))
return snippets
