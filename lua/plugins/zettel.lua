local M = {}

-- ── Configuration ────────────────────────────────────────────────────────────
M.config = {
    notes_dir = vim.fn.expand("~/Documents/Notes/"), -- change this to your notes directory
}

-- ── Helpers ──────────────────────────────────────────────────────────────────

local function note_id_func()
    -- Always generate a generic ID with YYMMDD-HHMM + 4 random uppercase letters
    local date_time = os.date("*t")
    local yy = string.format("%02d", date_time.year % 100)
    local mm = string.format("%02d", date_time.month)
    local dd = string.format("%02d", date_time.day)
    local hh = string.format("%02d", date_time.hour)
    local min = string.format("%02d", date_time.min)

    local suffix = ""
    for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
    end

    return yy .. mm .. dd .. "-" .. hh .. min .. "-" .. suffix
end

-- Returns true if we're inside a math block ($$...$$, $...$, \[...\])
local function in_math_context()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1], cursor[2]
    local lines = vim.api.nvim_buf_get_lines(0, 0, row, false)
    local text_up_to_cursor = table.concat(lines, "\n")
        .. vim.api.nvim_get_current_line():sub(1, col)

    -- Count $$ blocks
    local _, display_count = text_up_to_cursor:gsub("%$%$", "")
    if display_count % 2 == 1 then return true end

    -- Count inline $ (only odd number of $ means we're inside one)
    -- Strip $$ first to avoid double-counting
    local stripped = text_up_to_cursor:gsub("%$%$", "")
    local _, inline_count = stripped:gsub("%$", "")
    if inline_count % 2 == 1 then return true end

    -- \[...\] blocks
    local in_bracket = stripped:find("%\\%[") and not stripped:find("%\\%]$")
    if in_bracket then return true end

    return false
end

-- Returns all .md files in notes_dir as a list of {display, path}
local function get_notes()
    local notes = {}
    local dir = M.config.notes_dir
    local handle = vim.loop.fs_scandir(dir)
    if not handle then return notes end
    while true do
        local name, type = vim.loop.fs_scandir_next(handle)
        if not name then break end
        if type == "file" and name:match("%.md$") then
            table.insert(notes, {
                display = name:gsub("%.md$", ""),
                path = dir .. name,
            })
        end
    end
    return notes
end

-- Read YAML frontmatter from a file, return raw string
local function read_frontmatter(path)
    local f = io.open(path, "r")
    if not f then return nil end
    local content = f:read("*a")
    f:close()
    local fm = content:match("^%-%-%-\n(.-)\n%-%-%-")
    return fm
end

-- Parse tags and aliases from frontmatter string
local function parse_frontmatter(fm)
    if not fm then return nil, nil, {}, {} end
    local id, title = nil, nil

    local tags, aliases = {}, {}

    local in_tags, in_aliases = false, false
    for line in fm:gmatch("[^\n]+") do
        if line:match("^id:") then
            id = line:match("^id:%s*(.+)")
        elseif line:match("^title:") then
            title = line:match("^title:%s*(.+)")
        elseif line:match("^tags:") then
            in_tags, in_aliases = true, false
        elseif line:match("^aliases:") then
            in_aliases, in_tags = true, false
        elseif line:match("^%S") then
            in_tags, in_aliases = false, false
        elseif in_tags and line:match("^%s*%-%s*(.+)") then
            table.insert(tags, line:match("^%s*%-%s*(.+)"))
        elseif in_aliases and line:match("^%s*%-%s*(.+)") then
            table.insert(aliases, line:match("^%s*%-%s*(.+)"))
        end
    end
    return id, title, tags, aliases
end

local function setup_completion()
    local ok, cmp = pcall(require, "cmp")
    if not ok then return end


    cmp.event:on("confirm_done", function(event)
        local item = event.entry:get_completion_item() -- use get_completion_item()
        if item.user_data and item.user_data.on_select then
            item.user_data.on_select()
        end
    end)

    local source = {}
    source.new = function() return setmetatable({}, { __index = source }) end
    source.get_trigger_characters = function() return { "[" } end
    source.get_keyword_pattern = function() return [[\[\[\zs.*]] end

    source.complete = function(_, request, callback)
        if in_math_context() then
            callback({ items = {}, isIncomplete = false })
            return
        end

        local line = request.context.cursor_before_line
        local query = line:match("%[%[([^%]]*)")
        if not query then
            callback({ items = {}, isIncomplete = true })
            return
        end

        local notes = get_notes()
        local items = {}

        for _, note in ipairs(notes) do
            local fm = read_frontmatter(note.path)
            local id, title, _, aliases = parse_frontmatter(fm)
            if not title then
                title = note.display
            end
            table.insert(items, {
                label = title,
                insertText = id .. "|" .. title,
                kind = cmp.lsp.CompletionItemKind.File,
                detail = #aliases > 0 and ("aliases: " .. table.concat(aliases, ", ")) or nil,
            })
            for _, alias in ipairs(aliases) do
                table.insert(items, {
                    label = alias .. " → " .. title,
                    insertText = id .. "|" .. alias,
                    kind = cmp.lsp.CompletionItemKind.Reference,
                })
            end
        end
        -- Only add create item if query is non-empty
        if query ~= "" then
            local create_id = note_id_func()
            table.insert(items, {
                label = query .. "  (create)",
                insertText = create_id .. "|" .. query,
                kind = cmp.lsp.CompletionItemKind.File,
                user_data = {
                    on_select = function()
                        local cur_buf = vim.api.nvim_get_current_buf()
                        local cur_pos = vim.api.nvim_win_get_cursor(0)
                        M.new_note(create_id, query)
                        vim.cmd("write")
                        vim.api.nvim_set_current_buf(cur_buf)
                        vim.api.nvim_win_set_cursor(0, cur_pos)
                    end
                }
            })
        end

        callback({ items = items, isIncomplete = true })
    end

    cmp.register_source("zettel", source)
end

-- ── Follow link under cursor ──────────────────────────────────────────────────

function M.follow_link()
    local line = vim.api.nvim_get_current_line()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local col = cursor[2] + 1

    for inner in line:gmatch("%[%[(.-)%]%]") do
        local s, e = line:find("%[%[" .. vim.pesc(inner) .. "%]%]")
        if s and col >= s and col <= e then
            -- Strip display text after |
            local first, second = inner:match("^(.-)%s*|%s*(.-)$")
            local target_id, target_name
            if first and second then
                target_id = vim.trim(first)
                target_name = vim.trim(second)
            else
                target_id = nil
                target_name = vim.trim(inner)
            end

            local notes = get_notes()
            for _, note in ipairs(notes) do
                local fm = read_frontmatter(note.path)
                local id = parse_frontmatter(fm)
                if id == target_id then
                    vim.cmd("edit " .. vim.fn.fnameescape(note.path))
                    return
                end
            end

            -- Offer to create
            local choice = vim.fn.confirm(
                "Note '" .. target_name .. "' not found. Create it?", "&Yes\n&No", 1)
            if choice == 1 then
                if not target_id then
                target_id = note_id_func()
                end
                local new_inner = target_id .. "|" .. target_name
                local new_line = line:sub(1, s - 1) .. "[[" .. new_inner .. "]]" .. line:sub(e + 1)
                vim.api.nvim_set_current_line(new_line)
                M.new_note(target_id, target_name)
            end
            return
        end
    end
    vim.notify("No [[link]] under cursor", vim.log.levels.INFO)
end

-- ── FZF pickers ─────────────────────────────────────────────────────────

-- Search notes by filename
function M.find_notes()
    require("fzf-lua").files({
        cwd = M.config.notes_dir,
        prompt = "Notes> ",
    })
end

-- Full-text search across notes
--
function M.grep_notes()
    require("fzf-lua").live_grep({
        cwd = M.config.notes_dir,
        prompt = "Grep Notes> ",
    })
end

-- Search by tag (reads frontmatter of every note)
function M.find_by_tag()
    local fzf = require("fzf-lua")

    -- Build tag map
    local tag_map = {}
    for _, note in ipairs(get_notes()) do
        local fm = read_frontmatter(note.path)
        local _, _, tags, _ = parse_frontmatter(fm)
        for _, tag in ipairs(tags) do
            tag_map[tag] = tag_map[tag] or {}
            table.insert(tag_map[tag], note)
        end
    end

    local tag_list = {}
    for tag, notes in pairs(tag_map) do
        table.insert(tag_list, tag .. " (" .. #notes .. ")")
    end

    fzf.fzf_exec(tag_list, {
        prompt = "Tag> ",
        actions = {
            ["default"] = function(selected)
                local tag = selected[1]:match("^(.-) %(")
                local notes = tag_map[tag]
                if #notes == 1 then
                    vim.cmd("edit " .. vim.fn.fnameescape(notes[1].path))
                    return
                end
                local note_list = {}
                for _, n in ipairs(notes) do
                    table.insert(note_list, n.display .. " (" .. n.path..")")
                end
                fzf.fzf_exec(note_list, {
                    prompt = "Note [" .. tag .. "]> ",
                    actions = {
                        ["default"] = function(sel)
                            local path = sel[1]:match("%((.+)%)")
                            vim.cmd("edit " .. vim.fn.fnameescape(path))
                        end,
                    },
                })
            end,
        },
    })
end

-- ── New note ──────────────────────────────────────────────────────────────────

function M.new_note(id, title)
    id = id or note_id_func()
    title = title or vim.fn.input("Note title: ")
    if title == "" then return end
    local filename = title:gsub("%s+", "-"):lower() .. ".md"
    local path = M.config.notes_dir .. filename
    vim.cmd("edit " .. vim.fn.fnameescape(path))
    -- Insert starter frontmatter if the file is new
    if vim.fn.filereadable(path) == 0 then
        vim.api.nvim_buf_set_lines(0, 0, 0, false, {
            "---",
            "id: " .. id,
            "title: " .. title,
            "tags: ",
            "aliases: ",
            "---",
            "",
            "",
        })
        vim.api.nvim_win_set_cursor(0, { 8, 0 })
    end
end

-- ── Autocommands & keymaps (only for .md files in notes_dir) ─────────────────
function M.setup(user_config)
    M.config = vim.tbl_deep_extend("force", M.config, user_config or {})

    setup_completion()

    local notes_dir = M.config.notes_dir

    vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "*.md",
        callback = function()
            local bufpath = vim.fn.expand("%:p")
            -- Only activate for files inside notes_dir
            if not bufpath:find(notes_dir, 1, true) then return end

            local buf = vim.api.nvim_get_current_buf()

            --vim.keymap.set("i", "[[", function()
            --    local cursor = vim.api.nvim_win_get_cursor(0)
            --    local row, col = cursor[1], cursor[2]

            --    local notes = get_notes()
            --    local items = {}
            --    for _, n in ipairs(notes) do
            --        table.insert(items, n.display)
            --    end
            --    require("fzf-lua").fzf_exec(items, {
            --        prompt = "Link> ",
            --        actions = {
            --            ["default"] = function(selected)
            --                -- Insert the completed link at cursor
            --                local insert = "[[" .. selected[1] .. "]]"
            --                local line = vim.api.nvim_get_current_line()
            --                local new_line = line:sub(1, col) .. insert .. line:sub(col + 1)
            --                vim.api.nvim_buf_set_lines(0, row - 1, row, false, { new_line })
            --                vim.api.nvim_win_set_cursor(0, { row, col + #insert })
            --            end,
            --        },
            --    })
            --end, { buffer = true, desc = "Zettel: insert link" })

            -- Enable our completion source
            local ok, cmp = pcall(require, "cmp")
            if ok then
                cmp.setup.buffer({
                    sources = cmp.config.sources({
                        { name = "zettel" },
                        { name = "buffer" },
                    })
                })
            end

            -- Buffer-local keymaps
            local map = function(lhs, rhs, desc)
                vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
            end
            map("<leader>zf", M.find_notes, "Zettel: find note")
            map("<leader>zg", M.grep_notes, "Zettel: grep notes")
            map("<leader>zt", M.find_by_tag, "Zettel: find by tag")
            map("<leader>zn", M.new_note, "Zettel: new note")
            map("<CR>", M.follow_link, "Zettel: follow [[link]]")
        end,
    })
end

return M
