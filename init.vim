" specify plugins directory
call plug#begin(stdpath('data').'/plugged')

" installed plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'preservim/nerdcommenter'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'nanotech/jellybeans.vim'

" initialize vim-plug
call plug#end()

" non-plugin configurations
" automatic indentation
set autoindent
set smartindent
set cindent
" show line number and cursor position
set number
set ruler
" search casing, highlighting and incremental search
set smartcase
set hlsearch
set incsearch
" number of lines before and above cursor
set scrolloff=2
" command line completion
set wildmode=longest,list
" enable autoread(sync) and autowrite
set autowrite
set autoread
" use backspace everywhere
set backspace=eol,start,indent
" command history size
set history=256
" tab and indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4
set showmatch
" show matching parenthesis
set smarttab
" statusline configuration
set laststatus=2
set statusline=\ %<%l:%v\ [%P]%=%a\ %h%m%r\ %F\

" save cursor position
au BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\ exe "norm g`\"" |
\ endif

" enable writing Korean characters
if $LANG[0]=='k' && $LANG[1]=='o'
set fileencoding=korea
endif

" enable syntax highlighting
if has("syntax")
 syntax on
endif

" insert mode movements
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" enable 256 colors (for Linux, macOS)
" set t_Co=256
" colorscheme
colorscheme jellybeans

" autocmd configurations
" disable .tex spell check
autocmd BufNewFile,BufRead *.tex set nospell

" coc.nvim configurations
" textEdit might fail if hidden is not set
set hidden

" some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" give more space for displaying messages
set cmdheight=2

" having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience
set updatetime=300

" don't pass messages to |ins-completion-menu|
set shortmess+=c

" always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" use <c-space> to trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" goto code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
	
	" applying codeAction to the selected region
" example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" map function and class text objects
" note: Requires 'textDocument.documentSymbol' support from the language server
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" use CTRL-S for selections ranges
" requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" add `:Format` command to format current buffer
command! -nargs=0 Format :call CocAction('format')

" add `:Fold` command to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" add `:OR` command for organize imports of the current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" add (Neo)Vim's native statusline support
" note: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" mappings using CoCList
" show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" do default action for next item
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" do default action for previous item
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
