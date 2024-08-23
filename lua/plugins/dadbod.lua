return {
    'tpope/vim-dadbod',
    'pbogut/vim-dadbod-ssh',
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
        { 'tpope/vim-dadbod', lazy = true },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    },
    cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    init = function()
        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1
        vim.g.dbs = {
            flightdb = "mysql://metabase@k/flightdb",
            bwf064d01 = "sqlserver://bwfsa@bwf064d01"
        }
    end,
}
