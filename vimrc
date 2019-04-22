
" PLUGIN MANAGER
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify directory for plugins
call plug#begin('~/.vim/plugged')

" VERY IMPORTANT TO USE SINGLE QUOTES

" Using Jedi-Vim for python related stuff
Plug 'davidhalter/jedi-vim'

" NerdTree for stuff
Plug 'scrooloose/nerdtree'

" Finished Initialising Plugins
call plug#end()

" vimrc config from https://github.com/changemewtf/no_plugins/blob/master/no_plugins.vim
" Python configuration for tabs and spaces and all that
set tabstop=4
set shiftwidth=4
set expandtab

" FINDING FILES 
" Provide tab completion for all file-related tasks 
set path+=**

" Display all matchng files when we tab complete
set wildmenu

" CTAGS
command! MakeTags !ctags -R .

" Usage: 
" - ^] to jump to tag under cursor
" - g^] for ambiguous tags
" - ^t to jump back to tag stack

" The good stuff is documented in |ins-completion|

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list

" FILE BROWSING 

" tweaks for browsing
let g:netrw_baner=0        " disable annoying banner
let g:netrw_browse_split=4 " open in prior window
let g:netrw_altv=1         " open splits to the right
let g:netrw_liststyle=3    " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings

