local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require('luasnip.extras.fmt').fmta

-- True when the cursor is inside $...$ or $$...$$ (latex_block in the markdown_inline tree)
local function in_math()
    local ok, parser = pcall(vim.treesitter.get_parser)
    if not ok or not parser then return false end
    parser:parse(true)

    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    row = row - 1

    local function latex_at(r, c)
        local found = false
        parser:for_each_tree(function(tree, ltree)
            if found or ltree:lang() ~= 'markdown_inline' then return end
            local node = tree:root():named_descendant_for_range(r, c, r, c)
            while node do
                if node:type() == 'latex_block' then
                    found = true
                    return
                end
                node = node:parent()
            end
        end)
        return found
    end

    -- In insert mode the cursor sits after the typed text, so check that spot and the char before it
    return latex_at(row, col) or (col > 0 and latex_at(row, col - 1))
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
    -- Links and entering math
    auto('mk', fmta('$<>$', { i(1) }), { condition = not_in_math }),
    auto('dm', fmta([[
        $$
        <>
        $$
    ]], { i(1) }), { condition = not_in_math }),

    -- Auto-closing brackets, inside math only
    auto('(', { t('('), i(1), t(')') }, { wordTrig = false, condition = in_math }),
    auto('{', fmta('{<>}', { i(1) }), { wordTrig = false, condition = in_math }),
    auto('[', fmta('[<>]', { i(1) }), { wordTrig = false, condition = in_math }),
}

vim.list_extend(snippets, require('snippets.math')(in_math))
return snippets
