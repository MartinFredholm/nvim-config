return {
    cmd = { 'yaml-language-server', '--stdio' },
    filetypes = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab', 'yaml.helm-values' },
    root_dir = function(fname)
        return vim.fs.root(fname, { '.git' }) or vim.fs.dirname(fname)
    end,
    single_file_support = true,
    settings = {
        -- https://github.com/redhat-developer/vscode-redhat-telemetry#how-to-disable-telemetry-reporting
        redhat = { telemetry = { enabled = false } },
        -- formatting disabled by default in yaml-language-server; enable it
        yaml = { format = { enable = true } },
    },
}
