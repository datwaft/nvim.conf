return {
  hl = { fg = "overlay0", italic = true },
  {
    provider = "%l",
    hl = { bold = true },
  },
  {
    provider = " of ",
  },
  {
    provider = "%L",
    hl = { bold = true },
  },
  {
    provider = " lines",
  },
  {
    hl = { italic = false },
    {
      provider = " [",
    },
    {
      provider = "%P",
      hl = { bold = true },
    },
    {
      provider = "]",
    },
  },
}
