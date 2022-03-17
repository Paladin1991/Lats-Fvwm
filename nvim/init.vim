" ============= Vim-Plug ============== "{{{

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin(expand('~/.config/nvim/plugged'))

"}}}

" ================= looks and GUI stuff ================== "{{{

Plug 'ryanoasis/vim-devicons'                           " pretty icons everywhere
Plug 'luochen1990/rainbow'                              " rainbow parenthesis
Plug 'hzchirs/vim-material'                             " material color themes
Plug 'gregsexton/MatchTag'                              " highlight matching html tags
Plug 'Jorengarenar/vim-MvVis'                           " move visual selection
"}}}

" ================= Functionalities ================= "{{{
Plug 'turbio/bracey.vim'                                " Live server for HTML5
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'                               " SideBar
Plug 'neoclide/coc.nvim', {'branch': 'release'}         " LSP and more
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }     " fzf itself
Plug 'junegunn/fzf.vim'                                 " fuzzy search integration
Plug 'honza/vim-snippets'                               " actual snippets
Plug 'Yggdroot/indentLine'                              " show indentation lines
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}  " better python
Plug 'tpope/vim-commentary'                             " better commenting
Plug 'mhinz/vim-startify'                               " cool start up screen
Plug 'tpope/vim-fugitive'                               " git support
Plug 'psliwka/vim-smoothie'                             " some very smooth ass scrolling
Plug 'wellle/tmux-complete.vim'                         " complete words from a tmux panes
Plug 'tpope/vim-eunuch'                                 " run common Unix commands inside Vim
Plug 'machakann/vim-sandwich'                           " make sandwiches
Plug 'christoomey/vim-tmux-navigator'                   " seamless vim and tmux navigation
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'memgraph/cypher.vim'
Plug 'ollykel/v-vim'                                    " suport for V lang
call plug#end()

"}}}

" ==================== general config ======================== "{{{

set laststatus=2
set termguicolors                                       " Opaque Background
set mouse=a                                             " enable mouse scrolling
set clipboard+=unnamedplus                              " use system clipboard by default
set tabstop=4 softtabstop=4 shiftwidth=4 autoindent     " tab width
set expandtab smarttab                                  " tab key actions
set incsearch ignorecase smartcase hlsearch             " highlight text while searching
set list listchars=trail:»,tab:»-                       " use tab to navigate in list mode
set fillchars+=vert:\▏                                  " requires a patched nerd font (try FiraCode)
set wrap breakindent                                    " wrap long lines to the width set by tw
set encoding=utf-8                                      " text encoding
set number                                              " enable numbers on the left
"set relativenumber                                      " current line is 0
set title                                               " tab title as file name
set noshowmode                                          " dont show current mode below statusline
set noshowcmd                                           " to get rid of display of last command
set conceallevel=2                                      " set this so we wont break indentation plugin
set splitright                                          " open vertical split to the right
set splitbelow                                          " open horizontal split to the bottom
set tw=90                                               " auto wrap lines that are longer than that
set emoji                                               " enable emojis
set history=1000                                        " history limit
set backspace=indent,eol,start                          " sensible backspacing
set undofile                                            " enable persistent undo
set undodir=/tmp                                        " undo temp file directory
set foldlevel=0                                         " open all folds by default
set inccommand=nosplit                                  " visual feedback while substituting
set showtabline=0                                       " always show tabline
set grepprg=rg\ --vimgrep                               " use rg as default grepper

" performance tweaks
set nocursorline
set nocursorcolumn
set scrolljump=5
set lazyredraw
set redrawtime=10000
set synmaxcol=180
set re=1

" required by coc
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Themeing
let g:colors_name = "midnight"

let s:gui = {}
let s:cterm = {}
let s:gui.background = { 'dark': '#1E1E28', 'light': '#EBF5F7' }
let s:gui.foreground = { 'dark': '#ECEFF1', 'light': '#666666' }
let s:gui.none       = { 'dark': 'NONE',    'light': 'NONE' }
let s:gui.selection  = { 'dark': '#455A64', 'light': '#CCEAE7' }
let s:gui.line       = { 'dark': '#212121', 'light': '#EAEFF0' }
let s:gui.comment    = { 'dark': '#5D818E', 'light': '#90A4AE' }

let s:gui.red          = { 'dark': '#FF5370', 'light': '#E53935' }
let s:gui.pink         = { 'dark': '#F07178', 'light': '#FF5370' }
let s:gui.orange       = { 'dark': '#F78C6C', 'light': '#F76D47' }
let s:gui.light_yellow = { 'dark': '#FFE57F', 'light': '#FF9913' }
let s:gui.yellow       = { 'dark': '#FFCB6B', 'light': '#FF9913' }
let s:gui.green        = { 'dark': '#C3E88D', 'light': '#82A550' }
let s:gui.teal         = { 'dark': '#004D40', 'light': '#CCEAE7' }
let s:gui.light_teal   = { 'dark': '#69F0AE', 'light': '#73B6B0' }
let s:gui.pale_blue    = { 'dark': '#B2CCD6', 'light': '#8796B0' }
let s:gui.cyan         = { 'dark': '#89DDFF', 'light': '#39ADB5' }
let s:gui.blue         = { 'dark': '#82AAFF', 'light': '#6182B8' }
let s:gui.purple       = { 'dark': '#C792EA', 'light': '#7C4DFF' }
let s:gui.violet       = { 'dark': '#BB80B3', 'light': '#945EB8' }
let s:gui.brown        = { 'dark': '#AB7967', 'light': '#AB7967' }

if !exists('g:midnight_style')
  let g:midnight_style='default'
endif

function! s:hi(group, guifg, guibg, ctermfg, ctermbg, attr)
  if s:gui(a:guifg) != ""
    exec "hi " . a:group . " guifg=" . s:gui(a:guifg)
  endif
  if s:gui(a:guibg) != ""
    exec "hi " . a:group . " guibg=" . s:gui(a:guibg)
  endif
  if a:ctermfg != ""
    exec "hi " . a:group . " ctermfg=" . a:ctermfg
  endif
  if a:ctermbg != ""
    exec "hi " . a:group . " ctermbg=" . a:ctermbg
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfunction

function! s:gui(color)
  if &background == "light"
    return a:color['light']
  else
    if g:midnight_style == 'default'
      return a:color['dark']
    else
      return a:color[g:midnight_style]
    endif
  endif
endfunction

" Neovim Terminal colors
if has("nvim")
  let g:terminal_color_0  = s:gui(s:gui.background)
  let g:terminal_color_1  = s:gui(s:gui.red)
  let g:terminal_color_2  = s:gui(s:gui.green)
  let g:terminal_color_3  = s:gui(s:gui.light_yellow)
  let g:terminal_color_4  = s:gui(s:gui.blue)
  let g:terminal_color_5  = s:gui(s:gui.pink)
  let g:terminal_color_6  = s:gui(s:gui.light_teal)
  let g:terminal_color_7  = s:gui(s:gui.pale_blue)
  let g:terminal_color_8  = s:gui(s:gui.selection)
  let g:terminal_color_9  = s:gui(s:gui.red)
  let g:terminal_color_10 = s:gui(s:gui.green)
  let g:terminal_color_11 = s:gui(s:gui.light_yellow)
  let g:terminal_color_12 = s:gui(s:gui.cyan)
  let g:terminal_color_13 = s:gui(s:gui.purple)
  let g:terminal_color_14 = s:gui(s:gui.cyan)
  let g:terminal_color_15 = s:gui(s:gui.foreground)
endif

" Editor colors
call s:hi("ColorColumn",  s:gui.none,       s:gui.line,       "", "", "")
call s:hi("Cursor",       s:gui.yellow,     "",               "", "", "")
call s:hi("CursorColumn", s:gui.none,       s:gui.line,       "", "", "")
call s:hi("LineNr",       s:gui.comment,    "",               "", "", "")
call s:hi("CursorLine",   s:gui.none,       s:gui.line,       "", "", "")
call s:hi("CursorLineNr", s:gui.cyan,       s:gui.line,       "", "", "")
call s:hi("Directory",    s:gui.blue,       "",               "", "", "")
call s:hi("FoldColumn",   "",               s:gui.background, "", "", "")
call s:hi("Folded",       s:gui.comment,    s:gui.line,       "", "", "")
call s:hi("PMenu",        s:gui.foreground, s:gui.line,       "", "", "")
call s:hi("PMenuSel",     s:gui.cyan,       s:gui.selection,  "", "", "bold")
call s:hi("ErrorMsg",     s:gui.red,        s:gui.none,       "", "", "")
call s:hi("Error",        s:gui.red,        s:gui.none,       "", "", "")
call s:hi("WarningMsg",   s:gui.orange,     "",               "", "", "")
call s:hi("VertSplit",    s:gui.background, s:gui.foreground, "", "", "")
call s:hi("Conceal",      s:gui.comment,    s:gui.background, "", "", "")

call s:hi("DiffAdded",   s:gui.green, "", "", "", "")
call s:hi("DiffRemoved", s:gui.red,   "", "", "", "")

call s:hi("DiffAdd",    "",        s:gui.teal,       "", "", "")
call s:hi("DiffChange", "",        s:gui.teal,       "", "", "")
call s:hi("DiffDelete", s:gui.red, s:gui.background, "", "", "")
call s:hi("DiffText",   "",        s:gui.selection,  "", "", "")


call s:hi("NonText",     s:gui.comment,    "",               "", "", "")
call s:hi("helpExample", s:gui.blue,       "",               "", "", "")
call s:hi("MatchParen",  "",               s:gui.selection,  "", "", "")
call s:hi("Title",       s:gui.cyan,       "",               "", "", "")
call s:hi("Comment",     s:gui.comment,    "",               "", "", "italic")
call s:hi("String",      s:gui.green,      "",               "", "", "")
call s:hi("Normal",      s:gui.foreground, s:gui.background, "", "", "")
call s:hi("Visual",      "",               s:gui.selection,  "", "", "")
call s:hi("Constant",    s:gui.pink,       "",               "", "", "")
call s:hi("Type",        s:gui.yellow,     "",               "", "", "none")
call s:hi("Define",      s:gui.cyan,       "",               "", "", "")
call s:hi("Statement",   s:gui.cyan,       "",               "", "", "none")
call s:hi("Function",    s:gui.blue,       "",               "", "", "")
call s:hi("Conditional", s:gui.cyan,       "",               "", "", "")
call s:hi("Float",       s:gui.orange,     "",               "", "", "")
call s:hi("Noise",       s:gui.cyan,       "",               "", "", "")
call s:hi("Number",      s:gui.orange,     "",               "", "", "")
call s:hi("Identifier",  s:gui.pink,       "",               "", "", "")
call s:hi("Operator",    s:gui.cyan,       "",               "", "", "")
call s:hi("PreProc",     s:gui.blue,       "",               "", "", "")
call s:hi("Search",      s:gui.none,       s:gui.none,       "", "", "underline")
call s:hi("InSearch",    s:gui.background, s:gui.foreground, "", "", "")
call s:hi("Todo",        s:gui.red,        s:gui.foreground, "", "", "reverse")
call s:hi("Special",     s:gui.orange,     "",               "", "", "")
call s:hi("SignColumn",  "",               s:gui.background, "", "", "")


" Ruby colors
call s:hi("rubyClassName",       s:gui.yellow, "", "", "", "bold")
call s:hi("rubyConstant",        s:gui.yellow, "", "", "", "")
call s:hi("rubyKeywordAsMethod", s:gui.blue,   "", "", "", "")
call s:hi("rubyOperator",        s:gui.purple, "", "", "", "")
call s:hi("rubyPseudoVariable",  s:gui.red,   "", "", "", "italic")
call s:hi("rubySymbol",          s:gui.orange,   "", "", "", "")
call s:hi("rubySymbolDelimiter", s:gui.cyan,   "", "", "", "")

"eRuby colors
call s:hi("eRubyDelimiter", s:gui.cyan, "", "", "", "")

" Elixir colors
call s:hi("elixirKeyword", s:gui.blue, "", "", "", "")

" Javascript colors
" yajs
call s:hi("javascriptArrayMethod",      s:gui.blue,       "", "", "", "")
call s:hi("javascriptBlock",            s:gui.cyan,       "", "", "", "")
call s:hi("javascriptBraces",           s:gui.cyan,       "", "", "", "")
call s:hi("javascriptBrackets",         s:gui.cyan,       "", "", "", "")
call s:hi("javascriptClassName",        s:gui.yellow,     "", "", "", "bold")
call s:hi("javascriptClassSuperName",   s:gui.yellow,     "", "", "", "")
call s:hi("javascriptExport",           s:gui.cyan,       "", "", "", "")
call s:hi("javascriptFuncKeyword",      s:gui.purple,     "", "", "", "")
call s:hi("javascriptIdentifierName",   s:gui.foreground, "", "", "", "")
call s:hi("javascriptLabel",            s:gui.foreground, "", "", "", "")
call s:hi("javascriptMethod",           s:gui.blue,       "", "", "", "")
call s:hi("javascriptObjectLabel",      s:gui.foreground, "", "", "", "")
call s:hi("javascriptObjectLabelColon", s:gui.cyan,       "", "", "", "")
call s:hi("javascriptObjectMethodName", s:gui.blue,       "", "", "", "")
call s:hi("javascriptOperator",         s:gui.purple,     "", "", "", "")
call s:hi("javascriptProperty",         s:gui.cyan,       "", "", "", "")
call s:hi("javascriptStringMethod",     s:gui.blue,       "", "", "", "")
call s:hi("javascriptVariable",         s:gui.purple,     "", "", "", "")

" vim-javascript
call s:hi("jsArrowFuncArgs",   s:gui.red,     "", "", "", "")
call s:hi("jsArrowFunction",   s:gui.purple,       "", "", "", "")
call s:hi("jsBooleanFalse",    s:gui.orange,       "", "", "", "")
call s:hi("jsBooleanTrue",     s:gui.orange,       "", "", "", "")
call s:hi("jsClassBraces",     s:gui.cyan,       "", "", "", "")
call s:hi("jsClassDefinition", s:gui.yellow,       "", "", "", "")
call s:hi("jsClassKeyword",    s:gui.purple,       "", "", "", "")
call s:hi("jsConditional",     s:gui.cyan,       "", "", "", "italic")
call s:hi("jsFuncArgs",        s:gui.red,     "", "", "", "")
call s:hi("jsFuncBraces",      s:gui.cyan,     "", "", "", "")
call s:hi("jsFuncCall",        s:gui.blue,       "", "", "", "")
call s:hi("jsFuncParens",      s:gui.cyan,     "", "", "", "")
call s:hi("jsFunction",        s:gui.purple,     "", "", "", "")
call s:hi("jsFunctionKey",     s:gui.blue,     "", "", "", "")
call s:hi("jsGlobalObjects",   s:gui.yellow,       "", "", "", "")
call s:hi("jsNoise",           s:gui.cyan,       "", "", "", "")
call s:hi("jsObjectKey",       s:gui.foreground,     "", "", "", "")
call s:hi("jsOperator",        s:gui.purple,     "", "", "", "")
call s:hi("jsParens",          s:gui.cyan, "", "", "", "")
call s:hi("jsReturn",          s:gui.cyan,       "", "", "", "italic")
call s:hi("jsStorageClass",    s:gui.purple,     "", "", "", "")
call s:hi("jsThis",            s:gui.red,     "", "", "", "italic")

" yats
call s:hi("typescriptAccessibilityModifier", s:gui.purple, "", "", "", "")
call s:hi("typescriptCall",                  s:gui.pink, "", "", "", "")
call s:hi("typescriptClassName",             s:gui.yellow, "", "", "", "")
call s:hi("typescriptExport",                s:gui.blue, "", "", "", "")
call s:hi("typescriptImport",                s:gui.blue, "", "", "", "")
call s:hi("typescriptInterfaceName",         s:gui.yellow, "", "", "", "")
call s:hi("typescriptPredefinedType",        s:gui.pale_blue, "", "", "", "")
call s:hi("typescriptVariable",              s:gui.purple, "", "", "", "")
call s:hi("typescriptOperator",              s:gui.purple, "", "", "", "")

" HTML colors
call s:hi("htmlTag",            s:gui.cyan,   "", "", "", "")
call s:hi("htmlEndTag",         s:gui.cyan,   "", "", "", "")
call s:hi("htmlTagName",        s:gui.red,    "", "", "", "")
call s:hi("htmlSpecialTagName", s:gui.red,    "", "", "", "")
call s:hi("htmlArg",            s:gui.purple, "", "", "", "")

" jsx colors
call s:hi("xmlTag",     s:gui.cyan,   "", "", "", "")
call s:hi("xmlEndTag",  s:gui.cyan,   "", "", "", "")
call s:hi("xmlTagName", s:gui.red,    "", "", "", "")
call s:hi("xmlAttrib",  s:gui.yellow, "", "", "", "")

" GitGutter
call s:hi("GitGutterAdd",          s:gui.green, s:gui.background, "", "", "")
call s:hi("GitGutterChange",       s:gui.yellow,  s:gui.background, "", "", "")
call s:hi("GitGutterDelete",       s:gui.red,   s:gui.background, "", "", "")
call s:hi("GitGutterChangeDelete", s:gui.yellow,  s:gui.background, "", "", "")

" Treesitter
call s:hi("TSBoolean", s:gui.orange, "", "", "", "")
call s:hi("TSConstant", s:gui.foreground, "", "", "", "")
call s:hi("TSConstructor", s:gui.yellow, "", "", "", "")
call s:hi("TSKeyword", s:gui.cyan, "", "", "", "")
call s:hi("TSKeywordOperator", s:gui.cyan, "", "", "", "")
call s:hi("TSLabel", s:gui.pink, "", "", "", "")
call s:hi("TSOperator", s:gui.purple, "", "", "", "")
call s:hi("TSParameter", s:gui.red, "", "", "", "")
call s:hi("TSProperty", s:gui.foreground, "", "", "", "")
call s:hi("TSPunctBracket", s:gui.cyan, "", "", "", "")
call s:hi("TSPunctDelimiter", s:gui.cyan, "", "", "", "")
call s:hi("TSPunctSpecial", s:gui.cyan, "", "", "", "")
call s:hi("TSSymbol", s:gui.orange, "", "", "", "")
call s:hi("TSTag", s:gui.pink, "", "", "", "")
call s:hi("TSTagAttribute", s:gui.purple, "", "", "", "")
call s:hi("TSTagDelimiter", s:gui.cyan, "", "", "", "")
call s:hi("TSVariable", s:gui.foreground, "", "", "", "")
call s:hi("TSVariableBuiltIn", s:gui.red, "", "", "", "")

" Treesitter html
call s:hi("htmlEventDQ", s:gui.blue, "", "", "", "")

" Treesitter css
call s:hi("cssTSProperty", s:gui.yellow, "", "", "", "")

" Treesitter javascript
call s:hi("javascriptParens", s:gui.cyan, "", "", "", "")
call s:hi("javascriptValue", s:gui.orange, "", "", "", "")

hi Pmenu guibg='#100E10' guifg=white                    " popup menu colors
hi Comment gui=italic cterm=italic                      " italic comments
hi Search guibg=#b16286 guifg=#ebdbb2 gui=NONE          " search string highlight color
hi NonText guifg=bg                                     " mask ~ on empty lines
hi clear CursorLineNr                                   " use the theme color for relative number
hi CursorLineNr gui=bold                                " make relative number bold
hi SpellBad guifg=NONE gui=bold,undercurl               " misspelled words

" colors for git (especially the gutter)
hi DiffAdd  guibg=#0f111a guifg=#43a047
hi DiffChange guibg=#0f111a guifg=#fdd835
hi DiffRemoved guibg=#0f111a guifg=#e53935

" coc multi cursor highlight color
hi CocCursorRange guibg=#b16286 guifg=#ebdbb2

"}}}

" ======================== Plugin Configurations ======================== "{{{

" HTML sets
let g:user_emmet_install_global =  0
autocmd FileType html,css EmmeIntall
let g:user_emmet_leader_key='<c-z>'

if !has('gui_running')
  set t_Co=256
endif

"" built in plugins
let loaded_netrw = 0                                    " diable netew
let g:omni_sql_no_default_maps = 1                      " disable sql omni completion
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
if glob('~/.python3') != ''
  let g:python3_host_prog = expand('~/.python3/bin/python')
else
  let g:python3_host_prog = systemlist('which python3')[0]
endif

"" coc

" Navigate snippet placeholders using tab
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

" list of the extensions to make sure are always installed
let g:coc_global_extensions = [
            \'coc-yank',
            \'coc-pairs',
            \'coc-json',
            \'coc-css',
            \'coc-html',
            \'coc-tsserver',
            \'coc-yaml',
            \'coc-lists',
            \'coc-snippets',
            \'coc-pyright',
            \'coc-clangd',
            \'coc-prettier',
            \'coc-xml',
            \'coc-syntax',
            \'coc-git',
            \'coc-marketplace',
            \'coc-highlight',
            \'coc-sh',
            \]

" indentLine
let g:indentLine_char_list = ['▏', '¦', '┆', '┊']
let g:indentLine_setColors = 0
let g:indentLine_setConceal = 0                         " actually fix the annoying markdown links conversion
let g:indentLine_fileTypeExclude = ['startify']

"" startify
let g:startify_padding_left = 10
let g:startify_session_persistence = 1
let g:startify_enable_special = 0
let g:startify_change_to_vcs_root = 1
let g:startify_lists = [
    \ { 'type': 'dir'       },
    \ { 'type': 'files'     },
    \ { 'type': 'sessions'  },
    \ { 'type': 'bookmarks' },
    \ { 'type': 'commands' },
    \ ]

" bookmark examples
let  g:startify_bookmarks =  [
    \ {'v': '~/.config/nvim'},
    \ {'d': '~/.dotfiles' }
    \ ]

" custom commands
let g:startify_commands = [
    \ {'ch':  ['Health Check', ':checkhealth']},
    \ {'ps': ['Plugins status', ':PlugStatus']},
    \ {'pu': ['Update vim plugins',':PlugUpdate | PlugUpgrade']},
    \ {'uc': ['Update coc Plugins', ':CocUpdate']},
    \ {'h':  ['Help', ':help']},
    \ ]

" custom banner
let g:startify_custom_header = [
 \ '',
 \ '                                                    ▟▙            ',
 \ '                                                    ▝▘            ',
 \ '            ██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖',
 \ '            ██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██',
 \ '            ██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██',
 \ '            ██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██',
 \ '            ▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀',
 \ '',
 \ '',
 \ '',
 \]

" rainbow brackets
let g:rainbow_active = 1

" tmux navigator
let g:tmux_navigator_no_mappings = 1

" semshi settings
let g:semshi#error_sign	= v:false                       " let ms python lsp handle this

"" FZF
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'border': 'sharp' } }
let g:fzf_tags_command = 'ctags -R'

let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND = "rg --files --hidden --glob '!.git/**' --glob '!build/**' --glob '!.dart_tool/**' --glob '!.idea' --glob '!node_modules'"

"}}}

" ======================== Commands ============================= "{{{

au BufEnter * set fo-=c fo-=r fo-=o                     " stop annoying auto commenting on new lines
au FileType help wincmd L                               " open help in vertical split
au BufWritePre * :%s/\s\+$//e                           " remove trailing whitespaces before saving
au CursorHold * silent call CocActionAsync('highlight') " highlight match on cursor hold

" enable spell only if file type is normal text
let spellable = ['markdown', 'gitcommit', 'txt', 'text', 'liquid', 'rst']
autocmd BufEnter * if index(spellable, &ft) < 0 | set nospell | else | set spell | endif


" coc completion popup
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" startify if no passed argument or all buffers are closed
augroup noargs
    " startify when there is no open buffer left
    autocmd BufDelete * if empty(filter(tabpagebuflist(), '!buflisted(v:val)')) | Startify | endif

    " open startify on start if no argument was passed
    autocmd VimEnter * if argc() == 0 | Startify | endif
augroup END

" fzf if passed argument is a folder
augroup folderarg
    " change working directory to passed directory
    autocmd VimEnter * if argc() != 0 && isdirectory(argv()[0]) | execute 'cd' fnameescape(argv()[0])  | endif

    " start startify (fallback if fzf is closed)
    autocmd VimEnter * if argc() != 0 && isdirectory(argv()[0]) | Startify  | endif

    " start fzf on passed directory
    autocmd VimEnter * if argc() != 0 && isdirectory(argv()[0]) | execute 'Files ' fnameescape(argv()[0]) | endif
augroup END

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" python renaming and folding
augroup python
    autocmd FileType python nnoremap <leader>rn :Semshi rename <CR>
    autocmd FileType python set foldmethod=syntax
    autocmd FileType python syn sync fromstart
    autocmd FileType python syn region foldImports start='"""' end='"""' fold keepend
augroup end

" format with available file format formatter
command! -nargs=0 Format :call CocAction('format')

" organize imports
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" files in fzf
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--inline-info']}), <bang>0)

" advanced grep
command! -nargs=* -bang Rg call RipgrepFzf(<q-args>, <bang>0)

"}}}

" ================== Custom Functions ===================== "{{{

" advanced grep(faster with preview)
function! RipgrepFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
    let initial_command = printf(command_fmt, shellescape(a:query))
    let reload_command = printf(command_fmt, '{q}')
    let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

" startify file icons
function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

" check if last inserted char is a backspace (used by coc pmenu)
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" show docs on things with K
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"}}}

" ======================== Custom Mappings ====================== "{{{

"" the essentials
let mapleader=","
nnoremap ; :
nmap \ <leader>q
map <F6> :Startify <CR>
nmap <leader>r :so ~/.config/nvim/init.vim<CR>
nmap <leader>q :bd<CR>
nmap <leader>w :w<CR>
map <leader>s :Format<CR>
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
noremap <leader>e :PlugInstall<CR>
noremap <C-q> :q<CR>
noremap <C-s> :w<CR>

" new line in normal mode and back
map <Enter> o<ESC>
map <S-Enter> O<ESC>

" use a different register for delete and paste
nnoremap d "_d
vnoremap d "_d
vnoremap p "_dP
nnoremap x "_x

" emulate windows copy, cut behavior
vnoremap <LeftRelease> "+y<LeftRelease>
vnoremap <C-c> "+y<CR>
vnoremap <C-x> "+d<CR>

" switch between splits using ctrl + {h,j,k,l}
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
noremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" disable hl with 2 esc
noremap <silent><esc> <esc>:noh<CR><esc>

" trim white spaces
nnoremap <F2> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" markdown preview
au FileType markdown nmap <leader>m :MarkdownPreview<CR>

"" FZF
nnoremap <silent> <leader>f :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>c :Commands<CR>
nmap <leader>t :BTags<CR>
nmap <leader>/ :Rg<CR>
nmap <leader>gc :Commits<CR>
nmap <leader>gs :GFiles?<CR>
nmap <leader>sh :History/<CR>

" show mapping on all modes with F1
nmap <F1> <plug>(fzf-maps-n)
imap <F1> <plug>(fzf-maps-i)
vmap <F1> <plug>(fzf-maps-x)

"" coc

" use tab to navigate snippet placeholders
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use enter to accept snippet expansion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<CR>"

" multi cursor shortcuts
nmap <silent> <C-a> <Plug>(coc-cursors-word)
xmap <silent> <C-a> <Plug>(coc-cursors-range)

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" other stuff
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>o :OR <CR>

" jump stuff
nmap <leader>jd <Plug>(coc-definition)
nmap <leader>jy <Plug>(coc-type-definition)
nmap <leader>ji <Plug>(coc-implementation)
nmap <leader>jr <Plug>(coc-references)

" other coc actions
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <leader>a <Plug>(coc-codeaction-line)
xmap <leader>a <Plug>(coc-codeaction-selected)

" fugitive mappings
nmap <leader>gd :Gdiffsplit<CR>
nmap <leader>gb :Git blame<CR>

" tmux navigator
nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>

"}}}


" ======================== Additional sourcing ====================== "{{{
 source ~/.config/nvim/statusline.vim

"}}}
