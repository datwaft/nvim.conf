-- ==============
-- STATUSLINE.LUA
-- ==============
-- Created by: datwaft [github.com/datwaft]

--   This is a module that generates a status line from a palette and a configuration dictionary.
--   The palette follows the form:
--   {
--        background = string,
--        foreground = string,
--        black = string,
--        red = string,
--        green = string,
--        yellow = string,
--        blue = string,
--        purple = string,
--        cyan = string,
--        white = string,
--        lightgrey = string,
--        darkgrey = string,
--    }
--    And the configuration follows the form:
--    {
--       left_character = string,
--       right_character = string,
--    }
--

-- ==================
-- Auxiliar functions
-- ==================
   local titlecase = require'utils'.titlecase
   local highlight = require'utils'.highlight
-- ===================
-- Highlight utilities
-- ===================
   -- Define bubble highlight
   local function define_bubble_highlight(color, palette)
      vim.cmd('autocmd VimEnter * ' .. highlight('Bubble' .. titlecase(color), palette.background, palette[color]))
      vim.cmd('autocmd VimEnter * ' .. highlight('Bubble' .. titlecase(color) .. 'Bold', palette.background, palette[color], 'bold'))
      vim.cmd('autocmd VimEnter * ' .. highlight('Bubble' .. titlecase(color) .. 'Italic', palette.background, palette[color], 'italic'))
      vim.cmd('autocmd VimEnter * ' .. highlight('Bubble' .. titlecase(color) .. 'Delimiter', palette[color], palette.background))
   end
   local function define_dark_bubble_highlight(color, palette)
      vim.cmd('autocmd VimEnter * ' .. highlight('Bubble' .. titlecase(color), palette.foreground, palette[color]))
      vim.cmd('autocmd VimEnter * ' .. highlight('Bubble' .. titlecase(color) .. 'Bold', palette.foreground, palette[color], 'bold'))
      vim.cmd('autocmd VimEnter * ' .. highlight('Bubble' .. titlecase(color) .. 'Italic', palette.foreground, palette[color], 'italic'))
      vim.cmd('autocmd VimEnter * ' .. highlight('Bubble' .. titlecase(color) .. 'Delimiter', palette[color], palette.background))
   end
   -- define all status bar highlights
   local function define_highlights(palette)
      vim.cmd('autocmd VimEnter * ' .. highlight('StatusLine', palette.foreground, palette.background))
      define_bubble_highlight('black', palette)
      define_bubble_highlight('red', palette)
      define_bubble_highlight('green', palette)
      define_bubble_highlight('yellow', palette)
      define_bubble_highlight('blue', palette)
      define_bubble_highlight('purple', palette)
      define_bubble_highlight('cyan', palette)
      define_bubble_highlight('white', palette)
      define_dark_bubble_highlight('lightgrey', palette)
      define_dark_bubble_highlight('darkgrey', palette)
   end
-- =====================
-- Status bar components
-- =====================
   -- Render bubble
   local function render_bubble(list, configuration)
      -- list is a list of objects with the form:
      -- {
      --    data: string,
      --    color: string,
      --    type: string,
      -- }
      local function initial(color)
         return '%#Bubble' .. titlecase(color) .. 'Delimiter#' .. configuration.left_character
      end
      local function final(color)
         return '%#Bubble' .. titlecase(color) .. 'Delimiter#' .. configuration.right_character
      end
      local function islast(begin)
         for i=begin+1,#list do
            if list[i].data ~= '' then return false end
         end
         return true
      end
      local first = true
      local bubble = ''
      for i, e in ipairs(list) do
         if e.data ~= '' then
            local last = islast(i)
            if not e.type then e.type = '' end
            if first then bubble = bubble .. initial(e.color) end
            bubble = bubble .. '%#Bubble' .. titlecase(e.color) .. titlecase(e.type) .. '#'
            if not first then bubble = bubble .. ' ' end
            bubble = bubble .. e.data
            if not last then bubble = bubble .. ' ' end
            if last then bubble = bubble .. final(e.color) end
            if first then first = false end
         end
      end
      return bubble
   end
   -- Render mode bubble
   local function render_mode(configuration)
      local mode = vim.fn.mode()
      if mode == 'n' then
         return render_bubble({{ data = 'NORMAL', color = 'green', style = 'bold' }}, configuration)
      elseif mode == 'i' then
         return render_bubble({{ data = 'INSERT', color = 'blue', style = 'bold' }}, configuration)
      elseif mode == 'v' or mode == 'V' or mode == '^V' then
         return render_bubble({{ data = 'VISUAL', color = 'red', style = 'bold' }}, configuration)
      elseif mode == 'c' then
         return render_bubble({{ data = 'COMMAND', color = 'red', style = 'bold' }}, configuration)
      elseif mode == 't' then
         return render_bubble({{ data = 'TERMINAL', color = 'blue', style = 'bold' }}, configuration)
      elseif mode == 'R' then
         return render_bubble({{ data = 'REPLACE', color = 'yellow', style = 'bold' }}, configuration)
      else
         return render_bubble({{ data = vim.fn.mode(1), color = 'white', style = 'bold' }}, configuration)
      end
   end
   -- Path bubble
   local function path_bubble(configuration)
      return render_bubble({
         { data = ( vim.bo.ro and '' or '' ), color = 'lightgrey' },
         { data = '%.30f', color = 'white' },
         { data = ( vim.bo.mod and '+' or '' ), color = 'lightgrey' },
      }, configuration)
   end
   -- paste bubble
   local function paste_bubble(configuration)
      return render_bubble({{ data = ( vim.o.paste and 'PASTE' or '' ), color = 'red', style = 'bold' }}, configuration)
   end
   -- coc.nvim bubble
   local function coc_bubble(configuration)
      local info = vim.b.coc_diagnostic_info
      if info == nil or next(info) == nil then return '' end
      return render_bubble({
         { data = ( info.error ~= 0 and 'E' .. info.error or '' ), color = 'red', style = bold },
         { data = ( info.warning ~= 0 and 'W' .. info.warning or '' ), color = 'yellow', style = bold },
         { data = vim.g.coc_status, color = 'lightgrey', style = bold },
      }, configuration)
   end
   -- Progress bubble
   local function progress_bubble(configuration)
      return render_bubble({
         { data = '%-8.(%l:%c%)', color = 'lightgrey' },
         { data = '%P', color = 'darkgrey' },
      }, configuration)
   end
   -- Filetype bubble
   local function filetype_bubble(configuration)
      local filetype = vim.bo.filetype
      if filetype == '' then filetype = 'undefined'
      else filetype = filetype:lower() end
      return render_bubble({{ data = filetype, color = 'blue' }}, configuration)
   end
-- =====================
-- Status bar definition
-- =====================
   local function get_statusline(configuration)
      local statusline = ''

      -- render current mode
      statusline = statusline .. render_mode(configuration) .. ' '
      -- render path to file
      statusline = statusline .. path_bubble(configuration) .. ' '
      -- render paste bubble
      do local instance = paste_bubble(configuration)
         if instance ~= '' then
            statusline = statusline .. instance .. ' '
         end
      end
      -- render coc.nvim bubble
      do local instance = coc_bubble(configuration)
         if instance ~= '' then
            statusline = statusline .. instance .. ' '
         end
      end

      -- now define the right side
      statusline = statusline .. '%='

      -- render filetype of file
      statusline = statusline .. ' ' .. filetype_bubble(configuration)
      -- render progress of file
      statusline = statusline .. ' ' .. progress_bubble(configuration)

      return statusline
   end
-- ============
-- Final result
-- ============
   return {
      define_highlights = define_highlights,
      active = function()
         return get_statusline {
            left_character = '',
            right_character = '',
         }
      end,
      inactive = function()
         return get_statusline {
            left_character = '',
            right_character = '',
         }
      end,
   }
