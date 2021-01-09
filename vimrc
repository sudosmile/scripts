set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

" show number on right
set number
set autochdir
set tags=tags;
set encoding=UTF-8

" match parenthesis color
"hi MatchParen cterm=none ctermbg=brown ctermfg=gray

"let g:ale_completion_enabled = 1
"let g:ale_completion_autoimport = 1
"set omnifunc=ale#completion#OmniFunc

call plug#begin()
Plug 'zxqfl/tabnine-vim'
"Plug 'Valloric/YouCompleteMe'
"Plug 'haya14busa/incsearch.vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'nathanalderson/yanktohtml'
Plug 'craigemery/vim-autotag'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'sudosmile/vim-epitech'
"Plug 'w0rp/ale'
Plug 'copy/deoplete-ocaml'
Plug 'preservim/nerdcommenter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex'  }
Plug 'lervag/vimtex'
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins'  }
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'ryanoasis/vim-devicons'
call plug#end()

" Nerdtree options
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Doplete option
let g:deoplete#enable_at_startup = 1

autocmd FileType c setlocal foldmethod=syntax


" dont know about this to be tested
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
let g:tokyonight_enable_italic = 1
colorscheme tokyonight
let g:lightline = {'colorscheme' : 'tokyonight'}
"let g:tokyonight_transparent_background = 1
"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

" latex viewer and compiler
autocmd Filetype tex setl updatetime=10
let g:livepreview_previewer = 'zathura'
let g:livepreview_cursorhold_recompile = 0

call deoplete#custom#var('omni', 'input_patterns', {
            \ 'tex': g:vimtex#re#deoplete
            \})
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:deoplete#complete_method = "complete"

call deoplete#custom#option('ignore_sources', {})
call deoplete#custom#option('ignore_sources.ocaml', ['buffer', 'around', 'member', 'tag'])
call deoplete#custom#option('auto_complete_delay', 0)"

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
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

let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
execute "set rtp+=" . g:opamshare . "/merlin/vim"

2match none
map <C-e> <esc>:2match none
map <C-g> :Goyo<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
