vim.pack.add({
    { src = "https://github.com/obsidian-nvim/obsidian.nvim", version = "v3.13.1" },
})
require('obsidian').setup({
    legacy_commands = false,
    disable_frontmatter = false,
    new_notes_location = "notes_subdir",
    workspaces = {
        {
            name = "Abyss",
            path = "~/Documents/Obsidian/Abyss",
            overrides = {
                notes_subdir = "Nodes",
            },
        },
    },
    completion = {
        nvim_cmp = false,
        blink = true,
        min_chars = 0,
    },
    picker = {
        name = 'fzf-lua',
    },

    templates = {
        folder = "Templates",
    },
    note_id_func = function(title)
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
    end,

    note_path_func = function(spec)
        local filename

        if spec.title ~= nil and spec.title ~= "" then
            -- Use title as filename, sanitized for file system
            filename = spec.title:gsub("[/\\:*?\"<>|]", "-"):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
        else
            -- Use the generic ID as filename
            filename = spec.id
        end

        local path = spec.dir / filename
        return path:with_suffix(".md")
    end,
    -- Override note_frontmatter_func to force tags to be written as inline array
    note_frontmatter_func = function(note)
        if note.title then
            note:add_alias(note.title)
        end
        if not note.tags or vim.tbl_isempty(note.tags) then
            note:add_tag('raw')
        end
        print(vim.inspect(note.aliases))
        local function deduplicate(arr)
            local seen = {}
            local result = {}
            for _, item in ipairs(arr) do
                --print("Before split:" .. vim.inspect(item))
                for split_item in vim.gsplit(item, ',') do
                    local trimmed = vim.trim(split_item)
                    --print("Split Item:" .. vim.inspect(split_item))
                    if not seen[trimmed] then
                        --print("Not seen before")
                        seen[trimmed] = true
                        table.insert(result, trimmed)
                    end
                end
            end
            --print(vim.inspect(result))
            return result
        end
        note.aliases = deduplicate(note.aliases)
        note.tags = deduplicate(note.tags)
        local out = {
            id = note.id,
            title = note.title,
            aliases = note.aliases,
            tags = vim.fn.join(note.tags, " ")
        }
        if note.metadata and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
                out[k] = v
            end
        end
        return out
    end,
})
