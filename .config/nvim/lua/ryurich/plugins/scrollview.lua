return {
"dstein64/nvim-scrollview",
event = {"BufReadPre", "BufNewFile"},
opts = {
  current_only = false,
  always_show = false,
  winblend = 50, -- transparency (100 = fully transparent)
  base = 'right',
  column = 2,
  signs_on_startup = {'diagnostics', 'folds', 'marks', 'search', 'spell'},
},
}
