set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

source ~/.vim/matchit/plugin/matchit.vim

let g:loaded_matchit = 1

autocmd BufWritePre * :%s/\s\+$//e

set relativenumber
set nu
set autochdir
set tags=tags;
set encoding=UTF-8
set noerrorbells
set hidden
set scrolloff=10
set nowrap
set tw=0
set incsearch
set nohlsearch
set colorcolumn=80
"set nobackup

" CTRL + _ prints length of selection
vnoremap <C-l> "-y:echo 'length' strlen(@-)<CR>"

set backspace=indent,eol,start

"testing
"set nohlsearch
" match parenthesis color
"hi MatchParen cterm=none ctermbg=brown ctermfg=gray

"let g:ale_completion_enabled = 1
"let g:ale_completion_autoimport = 1
"set omnifunc=ale#completion#OmniFunc

call plug#begin()
"Plug 'dense-analysis/ale'
"Plug 'Valloric/YouCompleteMe'
"Plug 'haya14busa/incsearch.vim'
Plug 'zxqfl/tabnine-vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'dense-analysis/ale'
Plug 'nathanalderson/yanktohtml'
Plug 'craigemery/vim-autotag'
Plug 'jiangmiao/auto-pairs'
Plug 'morhetz/gruvbox'
Plug 'machakann/vim-sandwich'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/tabular'
Plug 'lervag/vimtex'
Plug 'Lenovsky/nuake'
Plug 'vim-pandoc/vim-pandoc'
Plug 'gabrielelana/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install()  }, 'for': ['markdown', 'vim-plug'] }
Plug 'sudosmile/vim-epitech'
Plug 'sheerun/vim-polyglot'
Plug 'preservim/nerdcommenter'
Plug 'mattn/emmet-vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'jiangmiao/auto-pairs'
Plug 'ryanoasis/vim-devicons'
call plug#end()

" Nerdtree options
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1


autocmd FileType c setlocal foldmethod=syntax

" emmet
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key=','
autocmd FileType html,css EmmetInstall

syntax on

filetype plugin on

let g:NERDDefaultAlign = 'left'

for prefix in ['n', 'v']
    for key in ['<Up>', '<Down>', '<Left>', '<Right>']
        exe prefix . "noremap " . key . " <Nop>"
    endfor
endfor

" colorscheme
set termguicolors
let g:tokyonight_style = 'night' " available: night, storm
let g:tokyonight_enable_italic = 0
let g:tokyonight_disable_italic_comment = 1
colorscheme tokyonight
let g:lightline = {'colorscheme' : 'tokyonight'}
"let g:tokyonight_transparent_background = 1
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" latex viewer and compiler
autocmd Filetype tex setl updatetime=10
let g:livepreview_previewer = 'zathura'
let g:livepreview_cursorhold_recompile = 0

let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1


let g:ale_fix_on_save = 1
let g:ale_fixers = {
\       '*': ['remove_trailing_lines', 'trim_whitespace'],
\       'ocaml': ['ocamlformat', 'ocp-indent'],
\}

let g:ale_linters = {
\ 'python':['flake8'],
\ 'ocaml':['merlin'],
\}


2match none
map <C-e> <esc>:2match none
map <C-g> :Goyo<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

nnoremap <F4> :Nuake<CR>
inoremap <F4> <C-\><C-n>:Nuake<CR>
tnoremap <F4> <C-\><C-n>:Nuake<CR>

nnoremap <F3> :MerlinErrorCheck<CR>





autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif



" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
