-- CONFIGURATION.LUA
-- =================
-- Created by: datwaft [github.com/datwaft]

-- Terminal configuration
-- ======================
   -- Activate mouse
   vim.o.mouse = 'a'
-- Editor configuration
-- ====================
   -- Indentation configuration
   -- =========================
      -- Use spaces instead of tabs
      do local expandtab = true
        vim.o.expandtab = expandtab
        vim.bo.expandtab = expandtab
      end
      -- More intelligent tabulation
      do local smarttab = true
        vim.o.smarttab = smarttab
      end
      -- Number of spaces that a <Tab> counts for
      do local tabstop = 3
        vim.o.tabstop = tabstop
        vim.bo.tabstop = tabstop
      end
      -- Number of spaces used for autoindent
      do local shiftwidth = vim.o.tabstop
        vim.o.shiftwidth = shiftwidth
        vim.bo.shiftwidth = shiftwidth
      end
      -- Number of spaces a <Tab> counts for
      do local softtabstop = vim.o.tabstop
        vim.o.softtabstop = softtabstop
        vim.bo.softtabstop = softtabstop
      end
      -- Copy indent from current line when starting a new line
      do local autoindent = true
        vim.o.autoindent = autoindent
        vim.bo.autoindent = autoindent
      end
