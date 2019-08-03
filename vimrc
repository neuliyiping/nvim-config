" PLUGIN MANAGER
if empty(glob('~/.config/nvim/vim-plug/plug.vim'))
  silent !curl -fLo ~/.config/nvim/vim-plug/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $VIMRC
endif

" Specify directory for plugins: VERY IMPORTANT TO USE SINGLE QUOTES
call plug#begin('$VIMPLUG')

" Encoding and file format
set encoding=utf-8
set fileformat=unix
set t_Co=256
"
" Set Mouse to integrate with the rest of the GUI
set mouse=a " a for all
set cursorline
set nu
set scrolloff=2
set noshowmode
set showcmd
set noswapfile
set nowrap
set splitright
set splitbelow
set clipboard=unnamed
set autoread " Autoreload files

" More natural split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Highlight search result and remap :nohs
nnoremap <silent> <leader><space> :noh<CR>
set hlsearch
set incsearch
set ignorecase
set smartcase

" Python configuration for tabs and spaces and all that
set expandtab
set smartindent
set smarttab " tab respects 'tabstop', 'shiftwidth', and 'softtabstop'
set tabstop=4 " the visible width of tabs
set softtabstop=4 " edit as if the tabs are 4 characters wide
set shiftwidth=4 " number of spaces to use for indent and unindent
set shiftround " round indent to a multiple of 'shiftwidth'
autocmd FileType json set shiftwidth=2 tabstop=2 softtabstop=2
autocmd BufRead,BufNewFile *.har set filetype=json
autocmd FileType yaml set shiftwidth=2 tabstop=2 softtabstop=2
" Remove trailing spaces
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" Format a json file
nnoremap <silent> <leader>j :%!python -m json.tool<CR>
set wildmenu
set path+=**
set wildignore+=**/__pycache__/**
nnoremap <leader>i :!isort -y % <CR> | redraw | update
nnoremap <leader>f :find 
nnoremap <leader>vf :vert sf 
" dot command in visual mode
vnoremap <leader>. :normal .<CR>

" Search recenters cursor
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
nnoremap <silent> g# g#zz
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> ^ g^
nnoremap <silent> $ g$
" Keep visual selection when indenting/unindenting
vmap < <gv
vmap > >gv

" Reload vimrc
nnoremap <leader>r :source $VIMRC<CR>

Plug 'arcticicestudio/nord-vim'

Plug 'mhinz/vim-startify'
	let g:startify_change_to_dir = 0
	let g:startify_change_to_vcs_root = 0 " Default

Plug 'luochen1990/rainbow'
    let g:rainbow_active = 1

Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'

Plug 'scrooloose/nerdtree'
    " Close vim if NERDTree is the only window
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    nnoremap <silent> <C-\> :NERDTreeToggle<CR>
    let NERDTreeQuitOnOpen = 1
    let NERDTreeAutoDeleteBuffer = 1
    let NERDTreeMinimalUI = 1
    let NERDTreeDirArrows = 1
    let NERDTreeShowHidden = 1
    let NERDTreeIgnore = ['\.pyc$', '__pycache__/', '.git/', '\.swp$']
    augroup nerdtree
		autocmd!
		autocmd FileType nerdtree setlocal nolist " turn off whitespace characters
		autocmd FileType nerdtree setlocal nocursorline " turn off line highlighting for performance
    augroup END

Plug 'scrooloose/nerdcommenter'

Plug 'itchyny/lightline.vim'
	let g:lightline = {
        \ 'colorscheme': 'nord',
        \ 'active': {
        \ 'left': [
        \     [ 'mode', 'paste' ],
        \     [ 'gitbranch', 'readonly', 'relname', 'modified' ],
        \ ],
        \ 'right': [
        \     ['percent'],  ['lineinfo'],
        \     ['filetype', 'fileformat', 'filenameencoding'],
        \     ['linter_errors', 'linter_warnings'],
        \ ],
        \ },
        \ 'inactive': {
        \ 'left': [
        \     ['mode'], ['relname'],
        \ ],
        \ 'right': [
        \ ],
        \ },
        \ 'component_function': {
        \     'gitbranch': 'LightlineGitBranch',
        \     'relname': 'LightlineFilename',
        \     'filenameencoding': 'LightlineFileEncoding',
        \     'fileformat': 'LightlineFileFormat',
        \ },
        \ 'component_type': {
        \     'readonly': 'error',
        \     'linter_warnings': 'warning',
        \     'linter_errors': 'error',
        \ },
        \ 'separator': {'left': "\ue0b0", 'right': "\ue0b2"},
    \ }

	function! LightlineFilename()
	let root = fnamemodify(get(b:, 'git_dir'), ':h')
	let path = expand('%:p')
	if path[:len(root)-1] ==# root
        let relfilename = path[len(root)+1:]
		return relfilename =~ '.git/' ? '' : relfilename
	endif
	return expand('%')
	endfunction

    function! LightlineFileEncoding()
        " Only return the file encoding if it's not utf-8
        return &fileencoding == 'utf-8' ? '' : &fileencoding
    endfunction

    function! LightlineFileFormat()
        " only show the file format if it's not 'unix'
        return &fileformat == 'unix' ? '' : &fileformat
    endfunction

    function! LightlineGitBranch()
        return " " . (exists('*fugitive#head') ? fugitive#head(): '')
    endfunction

Plug 'tpope/vim-fugitive'
	set diffopt+=vertical " Make vim-fugitive open vertical diff instead of horizontal
	" Add JIRA issue to commit message
	nnoremap <leader>g  :normal 5gg5wy$ggp<CR>a
    nnoremap <leader>gb :normal 5gg3wy$ggp<CR>a
	" highlight conflicts
	match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'ycm-core/YouCompleteMe', {'do': './install.py'}
	let g:ycm_autoclose_preview_window_after_insertion = 1
	let g:ycm_autoclose_preview_window_after_completion = 1
	nnoremap <silent> <leader>d :YcmCompleter GoTo<CR>
	nnoremap <silent> <leader>s :YcmCompleter GoToReferences<CR>

Plug 'vim-syntastic/syntastic'
	let g:syntastic_always_populate_loc_list = 1
	let g:syntastic_auto_loc_list = 0
	let g:syntastic_check_on_w = 1
	let g:syntastic_check_on_wq = 0
	let g:syntastic_auto_jump = 0
	let g:syntastic_python_checkers = ['flake8']

	nnoremap <silent> <F8> <ESC>:call SyntasticToggle()<CR>

	let g:syntastic_is_open = 0
	function! SyntasticToggle()
		if g:syntastic_is_open == 1
			lclose
			let g:syntastic_is_open = 0
		else
			Errors
			let g:syntastic_is_open = 1
		endif
	endfunction

Plug 'Yggdroot/indentLine'
	let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" Other plugins
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'wlemuel/vim-tldr'

Plug 'lervag/vimtex' " https://github.com/lervag/vimtex

Plug 'junegunn/goyo.vim'
	let g:goyo_width = 140
	let g:goyo_height = 90

call plug#end() " Finished Initialising Plugins

" Set the colorscheme
colorscheme nord

" vimrc config from https://github.com/changemewtf/no_plugins/blob/master/no_plugins.vim
set nocompatible
filetype plugin on
syntax on