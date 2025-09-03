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
            -- print("Parent type: " .. parent_type)
            -- print("Node type: " .. node_type)
            local result = parent_type == "latex_block" or node_type == "latex_block"
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
                $$
                <>
                $$
            ]],
            { i(1) })
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
                \begin{aligend}
                    <>
                \end{aligned}
            ]],
            { i(1) }
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
            trig = "(%d+)x(%d+)mat",
            name = "Matrix",
            regTrig = false,
            snippetType = "autosnippet",
            condition = in_math
        },
        fmta(
            [[
                \begin{bmatrix}
                <>
                \end{bmatrix}
            ]],
            d(1, function(args, snip)
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
            end)
        )
    ),
}
