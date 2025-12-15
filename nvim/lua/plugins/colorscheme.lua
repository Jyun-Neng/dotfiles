return {
  { "catppuccin/nvim", name = "catppuccin", opts = {
    transparent_background = true,
  } },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-mocha",
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
}
