-- ==============
-- STATUSLINE.LUA
-- ==============
-- Created by: datwaft [github.com/datwaft]

--   This is a module that generates a status line from a palette and a configuration dictionary.
--   The palette follows the form:
--   {
--        background = '...',
--        foreground = '...',
--        black = '...',
--        red = '...',
--        green = '...',
--        yellow = '...',
--        blue = '...',
--        purple = '...',
--        cyan = '...',
--        white = '...',
--        lightgrey = '...',
--        darkgrey = '...',
--    }
--    And the configuration follows the form:
--    {
--       left_character = '...',
--       right_character = '...',
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
   local function create_bubble(color, data, configuration, type)
      if type and type == 'bold' then
         return '%#Bubble' .. titlecase(color) .. 'Delimiter#' .. configuration.left_character ..
            '%#Bubble' .. titlecase(color) .. 'Bold#' .. data ..
            '%#Bubble' .. titlecase(color) .. 'Delimiter#' .. configuration.right_character ..
            '%#StatusBar#'
      elseif type and type == 'italic' then
         return '%#Bubble' .. titlecase(color) .. 'Delimiter#' .. configuration.left_character ..
            '%#Bubble' .. titlecase(color) .. 'Italic#' .. data ..
            '%#Bubble' .. titlecase(color) .. 'Delimiter#' .. configuration.right_character ..
            '%#StatusBar#'
      else
         return '%#Bubble' .. titlecase(color) .. 'Delimiter#' .. configuration.left_character ..
            '%#Bubble' .. titlecase(color) .. '#' .. data ..
            '%#Bubble' .. titlecase(color) .. 'Delimiter#' .. configuration.right_character ..
            '%#StatusBar#'
      end
   end
   -- Render mode bubble
   local function render_mode(configuration)
      local mode = vim.fn.mode()
      if mode == 'n' then
         return create_bubble('green', 'NORMAL', configuration, 'bold')
      elseif mode == 'i' then
         return create_bubble('blue', 'INSERT', configuration, 'bold')
      elseif mode == 'v' or mode == 'V' or mode == '^V' then
         return create_bubble('red', 'VISUAL', configuration, 'bold')
      elseif mode == 'c' then
         return create_bubble('red', 'COMMAND', configuration, 'bold')
      elseif mode == 't' then
         return create_bubble('blue', 'TERMINAL', configuration, 'bold')
      elseif mode == 'R' then
         return create_bubble('yellow', 'REPLACE', configuration, 'bold')
      else
         return create_bubble('white', vim.fn.mode(1), configuration, 'bold')
      end
   end
   -- Path bubble
   local function path_bubble(configuration)
      local bubble = ''
      if vim.bo.ro then
         bubble = bubble .. '%#BubbleLightgreyDelimiter#' .. configuration.left_character ..
            '%#BubbleLightgrey#' ..  '' .. ' '
      end

      if not vim.bo.ro then
         bubble = bubble .. '%#BubbleWhiteDelimiter#' .. configuration.left_character
      end
      bubble = bubble .. '%#BubbleWhiteItalic#'
      if vim.bo.ro then bubble = bubble .. ' ' end
      bubble = bubble .. '%.30f'
      if vim.bo.mod then bubble = bubble .. ' ' end
      if not vim.bo.mod then
         bubble = bubble .. '%#BubbleWhiteDelimiter#' .. configuration.right_character ..
            '%#StatusBar#'
      end

      if vim.bo.mod then
         bubble = bubble .. '%#BubbleLightgrey#' .. ' ' .. '+' ..
            '%#BubbleLightgreyDelimiter#' .. configuration.right_character ..
            '%#StatusBar#'
      end
      return bubble
   end
   -- paste bubble
   local function paste_bubble(configuration)
      if not vim.o.paste then
         return ''
      else
         return create_bubble('red', 'PASTE', configuration, 'bold')
      end
   end
   -- coc.nvim bubble
   local function coc_bubble(configuration)
      local info = vim.b.coc_diagnostic_info
      if info == nil or next(info) == nil then return '' end
      local begun = false
      local bubble = ''
      if info.error ~= 0 then
         begun = true
         bubble = bubble .. '%#BubbleRedDelimiter#' .. configuration.left_character ..
            '%#BubbleRedBold#' .. 'E' .. info.error
         if info.warning == 0 and vim.g.coc_status == '' then
            bubble = bubble .. '%#BubbleRedDelimiter#' .. configuration.right_character ..
               '%#StatusBar#'
         end
      end
      if info.warning ~= 0 then
         if not begun then
            bubble = bubble .. '%#BubbleYellowDelimiter#' .. configuration.left_character ..
               '%#BubbleYellowBold#' .. 'W' .. info.warning
            begun = true
         else
            bubble = bubble .. ' ' .. '%#BubbleYellowBold#' .. ' ' .. 'W' .. info.warning
         end
         if vim.g.coc_status == '' then
            bubble = bubble .. '%#BubbleYellowDelimiter#' .. configuration.right_character ..
               '%#StatusBar#'
         end
      end
      if vim.g.coc_status ~= '' then
         if not begun then
            bubble = bubble .. '%#BubbleLightgreyDelimiter#' .. configuration.left_character ..
               '%#BubbleLightgrey#' .. vim.g.coc_status ..
               '%#BubbleLightgreyDelimiter#' .. configuration.right_character ..
               '%#StatusBar#'
         else
            bubble = bubble .. ' ' .. '%#BubbleLightgrey#' .. ' ' .. vim.g.coc_status ..
               '%#BubbleLightgreyDelimiter#' .. configuration.right_character ..
               '%#StatusBar#'
         end
      end
      return bubble
   end
   -- Progress bubble
   local function progress_bubble(configuration)
      return '%#BubbleLightgreyDelimiter#' .. configuration.left_character ..
         '%#BubbleLightgrey#' .. ' ' ..
         '%-8.(' .. '%l' .. ':'  .. '%c' .. '%)' ..
         '%#BubbleDarkgrey#' .. ' %P' ..
         '%#BubbleDarkgreyDelimiter#' .. configuration.right_character ..
         '%#StatusBar#'
   end
   -- Filetype bubble
   local function filetype_bubble(configuration)
      local filetype = vim.bo.filetype
      if filetype == '' then filetype = 'undefined'
      else filetype = filetype:lower() end
      return create_bubble('blue', filetype, configuration)
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
      statusline = statusline .. paste_bubble(configuration) .. ' '
      -- render coc.nvim bubble
      do local instance = coc_bubble(configuration)
         if instace ~= '' then
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
