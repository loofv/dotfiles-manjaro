" ------------------------------------------------
" Loveh Nvim config
" ------------------------------------------------

" ------------------------------------------------
" Vim plug
" Skip auto install, make sure you install via Nvim instructions and not Vim.
" ------------------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'fladson/vim-kitty'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vimwiki/vimwiki'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'ianks/vim-tsx'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'uiiaoo/java-syntax.vim'
Plug 'rstacruz/vim-closer'
call plug#end()
" ------------------------------------------------
" Search (SK stuff)
" ------------------------------------------------
" Makes search better, see incsearch documentation with :help incsearch
set incsearch
set lazyredraw
set magic
set showmatch
set nohlsearch
" Makes search-and-replace show what is being replaced
set inccommand=nosplit
if executable('rg')
	set grepprg=rg\ --vimgrep
endif
" ------------------------------------------------
" Movement
" ------------------------------------------------
set mouse=a
" Use shift y to copy to system clipboard
nnoremap Y "+y
vnoremap Y "+y
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright
nnoremap <leader>t :b#<CR>
set scrolloff=10
" ------------------------------------------------
" Formatting and appearance
" ------------------------------------------------
" Enable autocompletion
set wildmenu
set wildmode=longest,list,full
set number
set relativenumber
set ignorecase
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
set termguicolors     " enable true colors support
" Theme
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
filetype plugin indent on
syntax on
" Hide ugly grey bar to the left
highlight SignColumn ctermbg=NONE guibg=NONE
" Enable transparent background in vim even when using themes
" If I start using my own theme, I should move these settings
hi Normal guibg=NONE ctermbg=NONE
" Tabs
set expandtab
set shiftwidth=4
set tabstop=4
" Make tabs visible
" set list
" set listchars=tab:>-
" ------------------------------------------------
" Key bindings
" ------------------------------------------------
let mapleader = " "
let g:mapleader = " "
" Search files in all subdirectories with FZF
nnoremap <leader>ff :FZF<CR>
nnoremap <leader>rg :Rg<CR>
nnoremap <leader>nt :NERDTree<CR>
" View current buffers
nnoremap <leader>bb :Buffers<CR>
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"
" Compile and run current java file within vim
nnoremap <F4> :split term://javac % && java %:r <CR>
" Check which syntax group the word my cursor is on belongs to
nmap <leader>cl :call <SID>SynStack()<CR>
" ------------------------------------------------
" Misc
" ------------------------------------------------
set noswapfile
" Be able to yank to regular clipboard
set clipboard+=unnamedplus
" ------------------------------------------------
" Plugin related settings
" ------------------------------------------------
"  Let nerdtree see hidden files, dotfiles etc.
let NERDTreeShowHidden=1
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Settings to make sure vim wiki works
set nocompatible
" TextEdit might fail if hidden is not set.
set hidden
" Coc
hi CocUnderline cterm=underline gui=underline
let g:coc_global_extensions=[ 'coc-tsserver', 'coc-git', 'coc-tslint', 'coc-json', 'coc-css', 'coc-java', 'coc-actions', 'coc-sh', 'coc-xml', 'coc-html', 'coc-vetur']
let g:coc_node_path = '/usr/local/bin/node'
" ------------------------------------------------
" Functions
" ------------------------------------------------
" Function to find id of syntax group that the cursor is on.
" I set this to a key binding.
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
" ------------------------------------------------
" Auto commands
" ------------------------------------------------
augroup autocommands
	autocmd!
	" Restore last cursor position and marks on open
	au BufReadPost *
				\ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
				\ |   exe "normal! g`\""
				\ | endif
    " Always start in insert mode when opening a terminal within Vim
    autocmd TermOpen * startinsert
	" Automatically deletes all trailing whitespace when saving.
	autocmd BufWritePre * %s/\s\+$//e
    " Automatically do Java imports when saving the file
    autocmd BufWritePre *.java call CocAction('runCommand', 'editor.action.organizeImport')
	" Automatically run source on this file after it has been edited to load changes
	autocmd! bufwritepost .config/nvim/init.vim source %
augroup END
