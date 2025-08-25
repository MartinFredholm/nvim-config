vim.pack.add({
    { src = "https://github.com/nvimdev/dashboard-nvim" },
})

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        require('dashboard').setup({
            theme = 'doom',
            config = {
                header = {
                    [[]],
                    [[]],
                    [[]],
                    [[]],
                    [[                                     @                     ]],
                    [[                                     @@                    ]],
                    [[  @                                  @@@                   ]],
                    [[   @@@@@@@@@  @@                    @@@@                   ]],
                    [[     @@@@@@@@@@@@@@@                @@@@                   ]],
                    [[           @@@@@@@@@@@@            @@@@@                   ]],
                    [[             @@@@@@@@@@@     @@@@@@@@@@@                   ]],
                    [[              @@@@@@@@@@@@@@@@@@@@@@@@@@                   ]],
                    [[              @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               ]],
                    [[               @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@          ]],
                    [[               @  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     ]],
                    [[                @  @@@@@@@@@@@@@@@@@@@      @@@@@@@@@@@@   ]],
                    [[                 @  @@@@@@@@@@@@@@@@@@@@@@  @@@@@@@@@@@@@  ]],
                    [[                  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  ]],
                    [[                    @@@@@@@@@@@@@@@@@@@            @@@@@@@ ]],
                    [[                      @@@@@@@@@@@@@@@    @@  @    @ @@@@@  ]],
                    [[                        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     ]],
                    [[                       @@@@@@@@@@@@@@@@@@@@@               ]],
                    [[                     @@@@@@@@@@@  @@@@@@@@@                ]],
                    [[                    @@@@@@@@     @@@@@@@@@                 ]],
                    [[                                 @@@@@@@                   ]],
                    [[                                  @@@                      ]],
                    [[                                                           ]],
                    [[]],
                    [[]],
                }, --your header
                header_hl = "DashboardHeader",
                center = {
                    {
                        icon = '  ',
                        icon_hl = 'DashboardIcon',
                        desc = '    Find File   ',
                        desc_hl = 'DashboardDesc',
                        key = 'f',
                        key_hl = 'DashboardKey',
                        key_format = ' %s',
                        action = 'FzfLua files'
                    },
                    {
                        icon = '  ',
                        icon_hl = 'DashboardIcon',
                        desc = '    Grep for text   ',
                        desc_hl = 'DashboardDesc',
                        key = 'g',
                        key_hl = 'DashboardKey',
                        key_format = ' %s',
                        action = 'FzfLua live_grep'
                    },
                    {
                        icon = '   ',
                        icon_hl = 'DashboardIcon',
                        desc = '    Go to config    ',
                        desc_hl = 'DashboardDesc',
                        key = 'c',
                        key_hl = 'DashboardKey',
                        key_format = ' %s',
                        action = function() require('oil').open(vim.fn.stdpath("config")) end
                    }
                },
                footer = { "Welcome back!" }, --your footer
                footer_hl = 'DashboardFooter',
                disable_move = true,
            }
        })
    end
})
