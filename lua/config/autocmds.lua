-- Highlight Yanked Text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.hl.on_yank()
    end,
})

-- Changes working directory to current directory if current directory
-- is not a subdirectory of previous working directory
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        -- Skip special buffers (terminals, help, etc.)
        if vim.bo.buftype ~= "" then
            return
        end

        local bufname = vim.api.nvim_buf_get_name(0)

        -- Skip virtual filesystems (oil://, fugitive://, etc.)
        if bufname:match("^%a+://") then
            return
        end

        local file_dir = vim.fn.expand("%:p:h")
        local cwd = vim.fn.getcwd()

        if file_dir == "" or vim.fn.isdirectory(file_dir) == 0 then
            return
        end
        -- Only cd if the file is NOT inside the current working directory
        if not vim.startswith(file_dir, cwd) then
            vim.cmd("cd " .. vim.fn.fnameescape(file_dir))
        end
    end,
})
