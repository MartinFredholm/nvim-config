local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local rep = require('luasnip.extras').rep
local r = require("luasnip.extras").restore_node
local fmta = require('luasnip.extras.fmt').fmta

-- Simpler version using treesitter if available
local function in_math()
    -- Try treesitter approach for markdown
    local ok, ts_utils = pcall(require, 'nvim-treesitter.ts_utils')
    if ok then
        local node = ts_utils.get_node_at_cursor()
        if node then
            -- Check if we're in a math node
            local node_type = node:type()
            local parent = node:parent()
            local parent_type = parent and parent:type() or ""
            print("Parent type: " .. parent_type)
            print("Node type: " .. node_type)
            local condition1 = node_type == "latex_block" or parent_type == "latex_block"
            local condition2 = node_type == "inline_formula" or parent_type == "inline_formula"
            local condition3 = node_type == "displayed_equation" or parent_type == "displayed_equation"
            local condition4 = node_type == "curly_group"
            local condition5 = parent_type == "generic_command" or parent_type == "generic_environment"
            local condition6 = parent_type == "subscript" or parent_type == "superscript" 
            local condition7 = node_type == "subscript" or node_type == "superscript" 
            local condition_inline = false
            if node_type == "inline" then
                -- Count inline math on current line
                -- Method 2: Fallback to line-based detection
                local line = vim.api.nvim_get_current_line()
                local col = vim.api.nvim_win_get_cursor(0)[2]
                local before = line:sub(1, col)
                local after = line:sub(col + 1)

                -- Count $ symbols before cursor
                local count = 0
                for _ in before:gmatch("%$") do count = count + 1 end

                condition_inline = count % 2 == 1
                if condition_inline then
                    print("Inline math detected")
                end
            end
            local result = condition_inline or condition1 or condition2 or condition3 or condition4 or condition5 or
            condition6
            print("In math: " .. tostring(result))
            return result
        end
    end
    return false
end

local function not_in_math()
    return not in_math()
end

return {

    --OUTSIDE OF MATH MODE--

    s(
        { trig = "mk", name = "InlineMath", priority = 100, snippetType = "autosnippet", condition = not_in_math },
        fmta("$<>$", { i(1) })
    ),
    s(
        { trig = "dm", name = "DisplayMath", priority = 100, snippetType = "autosnippet", condition = not_in_math },
        fmta(
            [[
                <>
                $$
                <>
                $$
            ]],
            { t({ "" }), i(1) })
    ),

    --INNSIDE OF MATH MODE--

    s(
        {
            trig = "beg",
            name = "Begin",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta(
            [[
                \begin{<>}
                    <>
                \end{<>}
            ]],
            { i(1), i(0), rep(1) }
        )
    ),
    s(
        {
            trig = "ali",
            name = "Aligned",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta(
            [[
                \begin{aligned}
                    <>
                \end{aligned}
            ]],
            { i(1) }
        )
    ),
    s(
        {
            trig = "bold",
            name = "Math bold",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta("\\mathbf{<>}",
            {
                i(1)
            }
        )
    ),
    s(
        {
            trig = "frac",
            name = "Fraction",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta("\\frac{<>}{<>}",
            {
                i(1), i(2)
            }
        )
    ),
    s(
        {
            trig = "(%d+)-(%d+)mat",
            name = "Matrix",
            priority = 100,
            regTrig = false,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta(
            [[
                \begin{<>matrix}
                <>
                \end{<>matrix}
            ]],
            {
                i(1),
                d(2, function(args, snip)
                    local nodes = {}
                    local index = 1
                    local rows = snip.captures[1]
                    local cols = snip.captures[2]
                    for k = 1, tonumber(rows) do
                        for j = 1, tonumber(cols) do
                            table.insert(nodes, i(index, tostring(index))) -- Add the number as a text node
                            if j < tonumber(cols) then
                                table.insert(nodes, t(" & "))
                            end
                            if j == tonumber(cols) then
                                if k < tonumber(rows) then
                                    table.insert(nodes, t("\\" .. "\\"))
                                    table.insert(nodes, t({ "", "" }))
                                end
                            end
                            index = index + 1
                        end
                    end
                    return sn(nil, nodes)
                end),
                rep(1)
            }
        )
    ),
    -- Variables and symbols
    s(
        {
            trig = "rho",
            name = "rho",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\rho")
    ),
    s(
        {
            trig = "tau",
            name = "tau",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\tau")
    ),
    s(
        {
            trig = "psi",
            name = "psi",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\psi")
    ),
    s(
        {
            trig = "phi",
            name = "phi",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\phi")
    ),
    s(
        {
            trig = "vphi",
            name = "varphi",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\varphi")
    ),
    s(
        {
            trig = "thet",
            name = "theta",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\theta")
    ),
    s(
        {
            trig = "psi",
            name = "psi",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\psi")
    ),
    s(
        {
            trig = "eps",
            name = "Epsilon",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\epsilon ")
    ),
    s(
        {
            trig = "delt",
            name = "Delta",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\delta ")
    ),
    s(
        {
            trig = "veps",
            name = "Varepsilon",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\varepsilon ")
    ),
    s(
        {
            trig = "alph",
            name = "Alpha",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\alpha ")
    ),


    -- Common functions
    s(
        {
            trig = "sin",
            name = "sin",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta("\\sin(<>)", i(1))
    ),
    s(
        {
            trig = "cos",
            name = "cos",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta("\\cos(<>)", i(1))
    ),
    s(
        {
            trig = "tan",
            name = "tan",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta("\\tan(<>)", i(1))
    ),
    s(
        {
            trig = "sqrt",
            name = "sqrt",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta("\\sqrt{<>}", i(1))
    ),

    -- common notation

    s(
        {
            trig = " %*",
            regTrig = false,
            wordTrig = false,
            name = "cdot",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\cdot ")
    ),
    s(
        {
            trig = "vec",
            name = "vec",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\vec ")
    ),
    s(
        {
            trig = "dot",
            name = "dot",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\dot ")
    ),
    s(
        {
            trig = "ddot",
            name = "ddot",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\ddot ")
    ),
    s(
        {
            trig = "diff",
            name = "diff",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta("\\frac{d <>}{d <>}", { i(1), i(2) })
    ),
    s(
        {
            trig = "partial",
            name = "partial",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta("\\frac{\\partial <>}{\\partial <>}", { i(1), i(2) })
    ),

    -- common formatting

    s(
        {
            trig = "quad",
            name = "quad",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\quad")
    ),
    s(
        {
            trig = "qquad",
            name = "qquad",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\qquad")
    ),
    s(
        {
            trig = "real",
            name = "Real",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        t("\\mathbb{R}")
    ),

    --- Sub- and superscript

    s({
            trig = "([a-zA-Z])(%d)",
            regTrig = true,
            wordTrig = false,
            name = "subscript",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        f(function(_, snip)
            return snip.captures[1] .. "_" .. snip.captures[2]
        end, {})
    ),
    s({
            trig = "([a-zA-Z])_(%d)(%d)",
            regTrig = true,
            wordTrig = false,
            name = "subscript_multi",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta("<>_{<><><>}", {
            f(function(_, snip) return snip.captures[1] end),
            f(function(_, snip) return snip.captures[2] end),
            f(function(_, snip) return snip.captures[3] end),
            i(1)
        })
    ),
    s({
            trig = "_",
            regTrig = true,
            wordTrig = false,
            name = "subscript_bracket",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta("_{<>}", i(1))
    ),
    s({
            trig = "%^",
            regTrig = true,
            wordTrig = false,
            name = "superscript_bracket",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta("^{<>}", i(1))
    ),
    s({
            trig = "%(",
            regTrig = true,
            wordTrig = false,
            snippetType = "autosnippet",
            priority = 100,
            condition = in_math
        },
        {
            t("("),
            i(1),
            t(")")
        }),
    s({
            trig = "%{",
            regTrig = true,
            wordTrig = false,
            name = "match_curl",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta("{<>}", i(1))
    ),

    s({
            trig = "%[",
            regTrig = true,
            wordTrig = false,
            name = "match_bracket",
            priority = 100,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta("[<>]", i(1))
    ),
}
