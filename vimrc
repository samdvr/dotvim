" enable pathogen to load vim bundles in ~/.vim/bundle/
" Generate help dogumentation with pathogen helptags helper
execute pathogen#infect()
execute pathogen#helptags()

" ==== Visual Settings ==== "

  " --- BASE16 Color --- "
  let base16colorspace=256  " base16 requires this to tell it to use 256 color space in iTerm
  set background=dark       " Tell vim that colorscheme is on a dark background
  colorscheme base16-ocean  " Use the base16-ocean colorscheme

set relativenumber " Line numbers relative to the cursor

set ruler " Turn on rulers

set number " Show line numbers

set numberwidth=5 " Min number of characters to use for the line number column

syntax on " enable syntax
autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile *.rabl set filetype=ruby

" Jump to last cursor position unless it's invalid or in an event handler
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

set cursorline " Underlines the cursors current line in the file

set scrolloff=5 "Minimum number of lines of context to keep around cursor

let &t_SI = "\<Esc>]50;CursorShape=1\x7" " insert mode vertical bar cursor
let &t_EI = "\<Esc>]50;CursorShape=0\x7" " all other modes bloack cursor

" ==== Performance Settings ==== "

" set regexp engine to old one full featured one. Turns out that the newer NFA
" regexp engine does NOT play nice with Ruby lang syntax highlighting.
" Switching to the older non NFA regexp engine drastically increases
" performance.
if exists('+regexpengine')
  set regexpengine=1
endif

" ==== Feature Settings ==== "

set shell=zsh " The shell to use is zsh

set nocompatible " Tell vim NOT to run in Vi compatible mode

filetype plugin indent on "smart indenting using ==
  " --- Tabs --- "
  set expandtab     " Use spaces to skip or insert when <BS>ing or <Tab>ing
  set tabstop=2     " Two spaces for tab
  set shiftwidth=2  " Number of spaces to use in each autoindent step
  set softtabstop=2 " Number of spaces to skip or insert when <BS>ing or <Tab>
  set shiftround    " Rounds the tab spaces when using > command

let mapleader = "," " Remap <Leader> key from \ (backslash) to , (comma)

" remap esc key for exiting insert mode
:imap jk <Esc>

" cyphactor/vim-open-alternate
nnoremap <leader>m :OpenAlternate<cr>

set textwidth=78  " Set the word wrap character limit to 78

set history=10000 " Number of : command entries to keep in history

" Ex mode command history behavior without arrow keys
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

set undolevels=1000 " Larger number of levels of undo
set showmatch " Show matching bracket when a bracket is inserted

set showcmd " Show imcomplete command

set backspace=2 " Backspace deletes like most programs in insert mode

  " --- Searching --- "
  set incsearch   " Find the next match as we type the search
  set hlsearch    " Highlight searches matching the search pattern
  set ignorecase  " ignore case when searching
  set complete=.,w,b,u,t " current buffer, window buffers, loaded buffers,
                         " unloaded buffers, tags
  map <leader>c :nohlsearch<cr>

set cmdheight=2 " Make the command entry area consume two rows

set showtabline=2 " ALWAYS show tab line at the top

  " --- Spellcheck --- "
  autocmd FileType markdown setlocal spell " Enable spellchecking in Markdown
  autocmd BufRead,BufNewFile *.md setlocal spell " Spell check md files
  autocmd FileType gitcommit setlocal spell " Spell check git commits
  set complete+=kspell " complete words in insert mode

  " --- Tab complete --- "
  " tabspace at beginning of line or complete word if not begining
  set wildmenu " Make tab completion for files/buffers act like bash
  set wildmode=list:longest,list:full " Tab complete show suggestion list, longest first
  function! InsertTabWrapper() " tabspace at begining of line or complete word
    let col = col('.') - 1
    if !col || getline('.')[col -1] !~ '\k'
      return "\<tab>"
    else
      return "\<c-p>"
    endif
  endfunction
  inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
  inoremap <S-Tab> <c-n>

  " --- No Arrow Keys --- "
  map <Left> :echo "STOP IT!"<cr>
  map <Right> :echo "STOP IT!"<cr>
  map <Up> :echo "STOP IT!"<cr>
  map <Down> :echo "STOP IT!"<cr>

  " --- NERDTREE --- "
  " ,n will toggle the nerd tree open and close
  map <leader>n :NERDTreeToggle<CR>
  let g:NERDTreeShowHidden=1 " Show hidden files in nerdtre

  " --- CTRL P --- "
  " search tags
  map <leader>gt :CtrlPTag<cr>
  " search current content of buffer
  map <leader>p :CtrlP .<cr>
  " search inside all files
  map <leader>P :CtrlP %%<cr>
  " search buffer
  map <leader>b :CtrlPBuffer<cr>
  let g:ctrlp_show_hidden = 1

  " --- Ack / Ag --- "
  let g:ackprg = 'ag --nogroup --nocolor --column' " use Ag with ack.vim
  nnoremap <leader>f :Ack!<space>

  " --- cyphactor/Test Recall --- "
  map <leader>t :call RunNearestTest()<cr>
  map <leader>T :call RunAllTestsInCurrentTestFile()<cr>
  map <leader>a :call RunAllRSpecTests()<cr>
  "map <leader>c :call RunAllCucumberFeatures()<cr>
  "map <leader>w :call RunWipCucumberFeatures()<cr>
  let g:vim_test_recall_rspec_command = 'bundle exec rspec'
