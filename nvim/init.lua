if vim.g.vscode then
  vim.keymap.set("i", "<C-l>", "<Right>")
  vim.keymap.set("i", "<C-h>", "<Left>")
  vim.keymap.set("i", "<C-j>", "<Down>")
  vim.keymap.set("i", "<C-k>", "<Up>")
else
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
end
