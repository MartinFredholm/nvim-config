vim.pack.add({
    { src = "https://github.com/obsidian-nvim/obsidian.nvim", version = "v3.13.1" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
})
require('plenary')
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
            print("inside")
            note:add_tag('raw')
        end
        local function deduplicate(arr)
            local seen = {}
            local result = {}
            for _, item in ipairs(arr) do
                if not seen[item] then
                    seen[item] = true
                    table.insert(result, item)
                end
            end
            return result
        end
        note.aliases = deduplicate(note.aliases)
        note.tags = deduplicate(note.tags)
        local out = {
            id = note.id,
            title = note.title,
            aliases = vim.fn.join(note.aliases, ", "),
            tags = vim.fn.join(note.tags, ", ")
        }
        if note.metadata and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
                out[k] = v
            end
        end
        return out
    end,
})
