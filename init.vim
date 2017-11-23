" Set leader keys
let mapleader=","
let maplocalleader=","

call plug#begin('~/.config/nvim/plugged')

function! DoRemote(arg)
	UpdateRemotePlugins
endfunction

Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-github-dashboard'
Plug 'kopischke/vim-stay'
Plug 'lervag/vimtex'
Plug 'mbbill/undotree'
Plug 'michaeljsmith/vim-indent-object'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdtree'
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive' 
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'wellle/targets.vim'

" Completion libraries
"Plug 'zchee/deoplete-jedi'

" On-demand loading
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }

call plug#end()

" Plugin settings

" airline settings
let g:airline_powerline_fonts=1
let g:airline_theme = 'hybrid'
let g:airline#extensions#tabline#enabled = 1

" deoplete settings
"
let g:deoplete#enable_at_startup = 1
" deoplete vimtex integration
if !exists('g:deoplete#omni#input_patterns')
	let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete
" deoplete-jedi settings
"autocmd CompleteDone * pclose!
autocmd FileType python setlocal completeopt-=preview

" neosnippet settings
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'
let g:neosnippet#enable_completed_snippet=1

" nerdtree settings

let NERDTreeMinimalUI=1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
" Open nerdtree if nvim launched without argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Open nerdtree if nvim launched with directory as argument
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | wincmd p | endif
" Close nvim if only nerdtree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" vimtex settings
let g:tex_flavor = "latex"
let g:vimtex_view_method = "zathura"
let g:vimtex_compiler_progname = "nvr"

" undotree settings
if !exists('g:undotree_WindowLayout')
	let g:undotree_WindowLayout = 3
endif
if !exists('g:undotree_HelpLine')
	let g:undotree_HelpLine = 0
endif

" vim-stay settings
set viewoptions=cursor,folds,slash,unix

" Theme settings
let g:hybrid_use_Xresources = 1
colorscheme hybrid

" Misc settings
set encoding=utf-8
set number
set relativenumber
set showcmd
set backspace=
set nojoinspaces
set tabstop=4
set shiftwidth=4
set title
set ignorecase smartcase
set cursorline
set lazyredraw
" Show indents and wraps
set list
set showbreak=↪\
set listchars=tab:→\ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨
" Don't select line numbers with mouse
set mouse=a
" Recommendations from Vim tutorial
filetype plugin indent on
syntax on
" Persistent undo
if has("persistent_undo")
	set undodir=~/.undodir/
	set undofile
endif

" User alias
command Fw w !sudo tee %

" General mappings

" Map homerow keys to resemble US layout
noremap ö [
noremap Ö {
noremap ä ]
noremap Ä }
noremap - /
noremap _ ?
noremap ? -
" Map B/E to beginning/end of line
nnoremap B ^
nnoremap E $
onoremap B ^
onoremap E $
" Movement in insert mode
inoremap <M-h> <C-o>h
inoremap <M-l> <C-o>a
inoremap <M-j> <C-o>j
inoremap <M-k> <C-o>k
" Map meta-q to exit insert mode
inoremap <M-n> <ESC>
" Map j/k to move by visual lines when not using count
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
" Map operation on entire buffer
onoremap af :<C-u>normal! ggVG<CR>
" Toggle absolute line numbers
function! NumberToggle()
	if(&relativenumber == 1)
		set relativenumber&
	else
		set relativenumber
	endif
endfunc
nmap <silent> <Leader>n :call NumberToggle()<CR>
" Save on Ctrl-S and update on F2
nmap <c-s> :w<CR>
vmap <c-s> <Esc><c-s>gv
imap <c-s> <Esc><c-s>
nmap <F2> :update<CR>
vmap <F2> <Esc><F2>gv
imap <F2> <c-o><F2>
" Remove all trailing whitespace by pressing F5
nnoremap <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" Hide highlights
nmap <silent> <Leader>h :noh<CR>
" Toggle visible indents and wraps
nmap <silent> <Leader>vi :set list!<CR>
" Toggle spellcheck
nmap <silent> <Leader>s :set spell!<CR>
" Create indent folds then return to manual fold method
nmap <silent> <Leader>f :setlocal foldmethod=indent<CR>:setlocal foldmethod=manual<CR>
" Erase all folds
nmap <silent> <Leader>F zE
" Toggle folds with space
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
" Buffer navigation
nnoremap <Leader>bt :e 
nnoremap <silent> <Leader>bo :enew<CR>
nnoremap <silent> <Leader>bh :bprevious<CR>
nnoremap <silent> <Leader>bl :bnext<CR>
nnoremap <silent> <Leader>bd :bdelete<CR>
nnoremap <silent> <Leader>bu :edit #<CR>
" Highlight last inserted text
nnoremap gV `[v`]

" Plugin mappings

" Toggle autocomplete
nmap <silent> <Leader>d :call deoplete#toggle()<CR>
" Toggle nerdtree
nmap <silent> <Leader>e :NERDTreeToggle<CR>
" Toggle undotree
nmap <silent> <Leader>u :UndotreeToggle<CR>
" Use TAB for deoplete navigation and neosnippet expansion
imap <expr><TAB>
	\ pumvisible() ? "\<C-n>" :
	\ neosnippet#expandable_or_jumpable() ?
	\    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
	smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
	\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
inoremap <expr><S-tab> pumvisible() ? "\<C-p>" : "\<S-tab>"
" Expand snippet
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" Expand snippet or insert suggestion
imap <expr><CR> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"
" Cancel suggestion or snippet insertion and close popup menu with Ctrl-Space
inoremap <expr><C-Space> pumvisible() ? "\<C-e>" : ""

