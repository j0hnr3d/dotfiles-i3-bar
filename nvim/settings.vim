:set number " Display line numbers on the left side
:set ls=2 " This makes Vim show a status line even when only one window is shown
:filetype plugin on " This line enables loading the plugin files for specific file types
:set tabstop=4 " Set tabstop to tell vim how many columns a tab counts for. Linux kernel code expects each tab to be eight columns wide.
:set expandtab " When expandtab is set, hitting Tab in insert mode will produce the appropriate number of spaces.
:set softtabstop=4 " Set softtabstop to control how many columns vim uses when you hit Tab in insert mode. If softtabstop is less than tabstop and expandtab is not set, vim will use a combination of tabs and spaces to make up the desired spacing. If softtabstop equals tabstop and expandtab is not set, vim will always use tabs. When expandtab is set, vim will always use the appropriate number of spaces.
:set shiftwidth=4 " Set shiftwidth to control how many columns text is indented with the reindent operations (<< and >>) and automatic C-style indentation. 
:set nowrap " Don't Wrap lines!
:set nocp " This changes the values of a LOT of options, enabling features which are not Vi compatible but really really nice
:set clipboard=unnamedplus
:set autoindent " Automatic indentation
:set cindent " This turns on C style indentation
:set si " Smart indent
:syntax enable " syntax highlighting
:set showmatch " Show matching brackets
:set hlsearch " Highlight in search
"":set ignorecase " Ignore case in search
:set noswapfile " Avoid swap files
:set mouse=a " Mouse Integration
:set cursorline " Highlight current line
:set encoding=UTF-8
" auto comment and uncoment with F6 and F7 key
:autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
:autocmd FileType sh,ruby,python   let b:comment_leader = '# '
:autocmd FileType vim   let b:comment_leader = '" '
" :autocmd VimEnter * NERDTree
:noremap <silent> #6 :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR> " commenting line with F6
:noremap <silent> #7 :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR> " uncommenting line with F7

:noremap <silent> #3 :tabprevious<CR> " switch to previous tab with F3
:noremap <silent> #4 :tabnext<CR> " switch to next tab with F2
:map <F8> :setlocal spell! spelllang=en_us<CR> " check spelling with F8
:noremap <silent> <F9> :b <TAB>
" plugins
" autocomplpop setting
:set omnifunc=syntaxcomplete " This is necessary for acp plugin
:let g:acp_behaviorKeywordLength = 1 "  Length of keyword characters before the cursor, which are needed to attempt keyword completion

" airline plugin setting
:let g:airline_theme='minimalist' " set airline plugin theme
:let g:airline#extensions#tabline#enabled = 1 " showing tabs 
:let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif
" Just show the filename (no path) in the tab
:let g:airline#extensions#tabline#fnamemod = ':t'
 " unicode symbols
"  let g:airline_left_sep = '»'
"  let g:airline_left_sep = '▶'
"  let g:airline_right_sep = '«'
"  let g:airline_right_sep = '◀'

"vim-airline-clock 
:let g:airline#extensions#clock#format = '%c'

" Use deoplete.
let g:deoplete#enable_at_startup = 1
" NERDTree plugin setting

"open a NERDTree automatically when vim starts up if no files were specified
:autocmd StdinReadPre * let s:std_in=1
:autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" close vim if the only window left open is a NERDTree
:autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Open file in new tab with ctrl + v
:let NERDTreeMapOpenInTab= '<c-u>'

"indentLine 
:let g:indentLine_char = '.'
" 24bit true colors
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
 if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1

 endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >

 if (has("termguicolors"))
   set termguicolors
 endif
endif

" srcery colorscheme
:let g:srcery_italic = 1
:let g:srcery_bold = 1
:let g:srcery_transparent_background = 0
:let g:srcery_underline = 1
:let g:srcery_undercurl = 1
:let g:srcery_inverse = 1
:let g:srcery_inverse_matches = 1
:let g:srcery_inverse_match_paren = 1
:let g:srcery_dim_lisp_paren = 1
" :color srcery
:set background=dark
:color deep-space
:let g:airline_theme='deep_space'
let g:deepspace_italics=1


" show qss file highlighting like css files 
au BufRead,BufNewFile *.qss set filetype=css

"call pylint
:autocmd FileType python :map <F10> :AsyncRun pylint ./%<CR><CR>
:map <F12> :bw!<CR> 

" Run/Compile stuffs
:autocmd FileType python :noremap <F5> :AsyncRun -raw python % <CR> 
:autocmd FileType sh  :noremap <F5> :AsyncRun bash % <CR> 
:autocmd FileType c  :noremap <F5> :AsyncRun gcc "%" -o "%<" % <CR>  
:autocmd FileType json syntax match Comment +\/\/.\+$+
:let g:vimspector_enable_mappings = 'HUMAN' " vimspector mappings 

"use <Tab> and <S-Tab> to navigate the completion list
:inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
:inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Mimic Emacs Line Editing in Insert Mode Only
:inoremap <C-A> <Home>
:inoremap <C-E> <End>
:inoremap <C-U> <Esc>d0xi
let vim_markdown_preview_browser='Google Chrome'

" Mail client configureation
function! SomeCheck()
   if filereadable("mail.vim")
       source mail.vim
   endif
endfunction
