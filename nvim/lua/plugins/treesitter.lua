return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    highlight = { enable = true },
    ensure_installed = {
      "c",
      "python",
      "verilog",
      "go",
    },
  },
}
