
""" Automatically create needed files and folders on first run (*nix only) {{{
    call system('mkdir -p $HOME/.vim/{autoload,bundle,swap,undo}')
    if !filereadable($HOME.'/.vimrc.plugins') | call system('touch $HOME/.vimrc.plugins') | endif
    if !filereadable($HOME.'/.vimrc.first') | call system('touch $HOME/.vimrc.first') | endif
    if !filereadable($HOME.'/.vimrc.last') | call system('touch $HOME/.vimrc.last') | endif
""" }}}
""" vim-plug plugin manager {{{
    " Automatic installation
    " https://github.com/junegunn/vim-plug/wiki/faq#automatic-installation
    if empty(glob('~/.vim/autoload/plug.vim'))
        let g:clone_details = 'https://github.com/junegunn/vim-plug.git $HOME/.vim/bundle/vim-plug'
        silent call system('git clone --depth 1 '. g:clone_details)
        if v:shell_error | silent call system('git clone ' . g:clone_details) | endif
        silent !ln -s $HOME/.vim/bundle/vim-plug/plug.vim $HOME/.vim/autoload/plug.vim
        augroup FirstPlugInstall
            autocmd! VimEnter * PlugInstall --sync | source $MYVIMRC
        augroup END
    endif

    """ Plugins to be disabled {{{
    """ https://github.com/timss/vimconf/issues/13
        " Create empty list with names of disabled plugins if not defined
        let g:plugs_disabled = get(g:, 'plug_disabled', [])

        " Trim and extract repo name
        " Same substitute/fnamemodify args as vim-plug itself
        " https://github.com/junegunn/vim-plug/issues/469#issuecomment-226965736
        function! s:plugs_disable(repo)
            let l:repo = substitute(a:repo, '[\/]\+$', '', '')
            let l:name = fnamemodify(l:repo, ':t:s?\.git$??')
            call add(g:plugs_disabled, l:name)
        endfunction

        " Append to list of repo names to be disabled just like they're added
        " UnPlug 'junegunn/vim-plug'
        command! -nargs=1 -bar UnPlug call s:plugs_disable(<args>)
    """ }}}

" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
    NeoBundleFetch 'Shougo/neobundle.vim'
    NeoBundle 'tiagofumo/vim-nerdtree-syntax-highlight'
    NeoBundle 'itchyny/lightline.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

    " Default to same plugin directory as vundle etc
    call plug#begin('~/.vim/bundle')

    "autocomplete syntax
    "Plug 'valloric/youcompleteme'

    Plug 'mkitt/tabline'

    "color for files in nerdtree
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

    Plug 'morhetz/gruvbox'

    "CSV File compatibility
    Plug 'chrisbra/csv.vim'

    "css colors
    Plug 'KabbAmine/vCoolor.vim'
    Plug 'ap/vim-css-color'

    " Unite vim
    Plug 'Shougo/unite.vim'

    " <Tab> everything!
    Plug 'ervandew/supertab'

    " Fuzzy finder (files, mru, etc)
    Plug 'ctrlpvim/ctrlp.vim'

    "Statusline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " A pretty statusline, bufferline integration

    Plug 'bling/vim-bufferline'

    " Undo history visualizer
    Plug 'mbbill/undotree'

    " Glorious colorscheme
    " To avoid errors during automatic installation
    " https://github.com/junegunn/vim-plug/issues/225
    Plug 'nanotech/jellybeans.vim'

    " Universal commenting with toggle, motions, embedded syntax and more
    Plug 'tomtom/tcomment_vim'

    " Autoclose (, " etc
    Plug 'somini/vim-autoclose'

    " UNIX shell command helpers, e.g. sudo, chmod, remove etc.
    Plug 'tpope/vim-eunuch'

    "NERDtree
    Plug 'preservim/nerdtree'

    " Git wrapper inside Vim
    Plug 'tpope/vim-fugitive'

    " Handle surround chars like ''
    Plug 'tpope/vim-surround'

    " Align your = etc.
    Plug 'junegunn/vim-easy-align'

    " Fzf for dir and file search
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    " Snippets like textmate
    if has('python') || has('python3')
        Plug 'honza/vim-snippets'
        Plug 'sirver/ultisnips'
    endif

    " A fancy start screen, shows MRU etc.
    Plug 'mhinz/vim-startify'

    " Vim signs (:h signs) for modified lines based off VCS (e.g. Git)
    Plug 'mhinz/vim-signify'

    " Awesome syntax checker.
    " REQUIREMENTS: See :h syntastic-intro
    Plug 'vim-syntastic/syntastic'

    "cursors
    Plug 'terryma/vim-multiple-cursors'

    " Functions, class data etc.
    " depends on either exuberant-ctags or universal-ctags
    if executable('ctags-exuberant') || executable('ctags')
        Plug 'majutsushi/tagbar'
    endif

    " Local plugins
    if filereadable($HOME.'/.vimrc.plugins')
        source $HOME/.vimrc.plugins
    endif

    " Remove disabled plugins from installation/initialization
    " https://vi.stackexchange.com/q/13471/5070
    call filter(g:plugs, 'index(g:plugs_disabled, v:key) == -1')

    " Initalize plugin system
    call plug#end()
""" }}}
""" Local leading config, only for prerequisites and will be overwritten {{{
    if filereadable($HOME.'/.vimrc.first')
        source $HOME/.vimrc.first
    endif
""" }}}
""" General settings {{{
    set completeopt=menu,preview,longest            " insert mode completion
    set hidden                                      " buffer change, more undo
    set history=1000                                " default 20
    set laststatus=2                                " always show statusline
    set linebreak                                   " don't cut words on wrap
    set listchars=tab:>\                            " > to highlight <Tab>
    set list                                        " displaying listchars
    set mouse=                                      " disable mouse
    set noshowmode                                  " hide mode cmd line
    set noexrc                                      " don't use other .*rc(s)
    set nostartofline                               " keep cursor column pos
    set nowrap                                      " don't wrap lines
    set numberwidth=5                               " 99999 lines
    set shortmess+=I                                " disable startup message
    set splitbelow                                  " splits go below w/focus
    set splitright                                  " vsplits go right w/focus
    set ttyfast                                     " for faster redraws etc
    set ttymouse=xterm2                             " experimental
    """ Folding {{{
        set foldcolumn=0                            " hide folding column
        set foldmethod=indent                       " folds using indent
        set foldnestmax=10                          " max 10 nested folds
        set foldlevelstart=99                       " folds open by default
    """ }}}
    """ Search and replace {{{
        set gdefault                                " default s//g (global)
        set incsearch                               " "live"-search
    """ }}}
    """ Matching {{{
        set matchtime=2                             " time to blink match {}
        set matchpairs+=<:>                         " for ci< or ci>
        set showmatch                               " tmpjump to match-bracket
    """ }}}
    """ Wildmode/wildmenu command-line completion {{{
        set wildignore+=*.bak,*.swp,*.swo
        set wildignore+=*.a,*.o,*.so,*.pyc,*.class
        set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.pdf
        set wildignore+=*/.git*,*.tar,*.zip
        set wildmenu
        set wildmode=longest:full,list:full
    """ }}}
    """ Return to last edit position when opening files {{{
        augroup LastPosition
            autocmd! BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \     exe "normal! g`\"" |
                \ endif
        augroup END
    """ }}}
""" }}}
""" Files {{{
    set autoread                                    " refresh if changed
    set confirm                                     " confirm changed files
    set noautowrite                                 " never autowrite
    set nobackup                                    " disable backups
    """ Persistent undo. Requires Vim 7.3 {{{
        if has('persistent_undo') && exists('&undodir')
            set undodir=$HOME/.vim/undo/            " where to store undofiles
            set undofile                            " enable undofile
            set undolevels=500                      " max undos stored
            set undoreload=10000                    " buffer stored undos
        endif
    """ }}}
    """ Swap files, unless vim is invoked using sudo {{{
    """ https://github.com/tejr/dotfiles/blob/master/vim/vimrc
        if !strlen($SUDO_USER)
            set directory^=$HOME/.vim/swap//        " default cwd, // full path
            set swapfile                            " enable swap files
            set updatecount=50                      " update swp after 50chars
            """ Don't swap tmp, mount or network dirs {{{
                augroup SwapIgnore
                    autocmd! BufNewFile,BufReadPre /tmp/*,/mnt/*,/media/*
                        \ setlocal noswapfile
                augroup END
            """ }}}
        else
            set noswapfile                          " dont swap sudo'ed files
        endif
    """ }}}
""" }}}
""" Text formatting {{{
    set autoindent                                  " preserve indentation
    set backspace=indent,eol,start                  " smart backspace
    set cinkeys-=0#                                 " don't force # indentation
    set expandtab                                   " indents <Tab> as spaces
    set ignorecase                                  " by default ignore case
    set nrformats+=alpha                            " incr/decr letters C-a/-x
    set shiftround                                  " round indent of 'sw'
    set shiftwidth=0                                " =0 uses 'ts' value
    set smartcase                                   " sensitive with uppercase
    set smarttab                                    " tab to 0,4,8 etc.
    set softtabstop=-1                              " =-1 uses 'sw' value
    set tabstop=4                                   " <Tab> as 4 spaces indent
    """ Only auto-comment newline for block comments {{{
        augroup AutoBlockComment
            autocmd! FileType c,cpp setlocal comments -=:// comments +=f://
        augroup END
    """ }}}
    """ Take comment leaders into account when joining lines, :h fo-table {{{
    """ http://ftp.vim.org/pub/vim/patches/7.3/7.3.541
        if has('patch-7.3.541')
            set formatoptions+=j
        endif
    """ }}}
""" }}}
""" Keybindings {{{
    """ General {{{
        " Remap <Leader>
        let g:mapleader=','

        " Quickly edit/source .vimrc
        noremap <Leader>ve :edit $HOME/.vimrc<CR>
        noremap <Leader>vs :source $HOME/.vimrc<CR>

        " Yank(copy) to system clipboard
        noremap <Leader>y "+y

        " Toggle pastemode, doesn't indent
        set pastetoggle=<F3>

        " Toggle folding
        " http://vim.wikia.com/wiki/Folding#Mappings_to_toggle_folds
        nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

        " Toggle relativenumber
        nnoremap <silent> <Leader>r :set relativenumber!<CR>

    nnoremap <silent> <Leader>ln :set invnumber<CR>

    " Treat wrapped lines as normal lines
    nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
    nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

    " Quickly switch buffers
    nnoremap <Leader>n :bnext<CR>
    nnoremap <Leader>p :bprevious<CR>
    nnoremap <Leader>f :b#<CR>
    nnoremap <Leader>1 :1b<CR>
    nnoremap <Leader>2 :2b<CR>
    nnoremap <Leader>3 :3b<CR>
    nnoremap <Leader>4 :4b<CR>
    nnoremap <Leader>5 :5b<CR>
    nnoremap <Leader>6 :6b<CR>
    nnoremap <Leader>7 :7b<CR>
    nnoremap <Leader>8 :8b<CR>
    nnoremap <Leader>9 :9b<CR>
    nnoremap <Leader>0 :10b<CR>

    " Highlight last inserted text
    nnoremap gV '[V']
""" }}}
""" Functions and/or fancy keybinds {{{
    """ Toggle syntax highlighting {{{
        function! ToggleSyntaxHighlighthing()
            if exists('g:syntax_on')
                syntax off
            else
                syntax enable
            endif
        endfunction

        nnoremap <Leader>s :call ToggleSyntaxHighlighthing()<CR>
    """ }}}
    """ Highlight characters past 79, toggle with <Leader>h {{{
    """ You might want to override this function and its variables with
    """ your own in .vimrc.last which might set for example colorcolumn or
    """ even the textwidth. See https://github.com/timss/vimconf/pull/4
        let g:overlength_enabled = 0
        highlight OverLength ctermbg=238 guibg=#444444

        function! ToggleOverLength()
            if g:overlength_enabled == 0
                match OverLength /\%79v.*/
                let g:overlength_enabled = 1
                echo 'OverLength highlighting turned on'
            else
                match
                let g:overlength_enabled = 0
                echo 'OverLength highlighting turned off'
            endif
        endfunction

        nnoremap <Leader>h :call ToggleOverLength()<CR>
    """ }}}
    """ Toggle text wrapping, wrap on whole words {{{
    """ For more info see: http://stackoverflow.com/a/2470885/1076493
        function! WrapToggle()
            if &wrap
                set list
                set nowrap
            else
                set nolist
                set wrap
            endif
        endfunction

        nnoremap <Leader>w :call WrapToggle()<CR>
    """ }}}
    """ Remove multiple empty lines {{{
        function! DeleteMultipleEmptyLines()
            g/^\_$\n\_^$/d
        endfunction

        nnoremap <Leader>ld :call DeleteMultipleEmptyLines()<CR>
        """ }}}
        """ Split to relative header/source {{{
            function! SplitRelSrc()
                let l:fname = expand('%:t:r')

                if expand('%:e') ==? 'h'
                    set nosplitright
                    exe 'vsplit' fnameescape(l:fname . '.cpp')
                    set splitright
                elseif expand('%:e') ==? 'cpp'
                    exe 'vsplit' fnameescape(l:fname . '.h')
                endif
            endfunction

            nnoremap <Leader>le :call SplitRelSrc()<CR>
        """ }}}
        """ Strip trailing whitespace, return to cursor at save {{{
            function! StripTrailingWhitespace()
                let l:save = winsaveview()
                %s/\s\+$//e
                call winrestview(l:save)
            endfunction

            augroup StripTrailingWhitespace
                autocmd!
                autocmd FileType c,cpp,cfg,conf,css,html,perl,python,sh,tex,yaml
                    \ autocmd BufWritePre <buffer> :call
                    \ StripTrailingWhitespace()
            augroup END
        """ }}}
    """ }}}
    """ Plugins {{{
        " Toggle tagbar (definitions, functions etc.)
        if exists('g:plugs["tagbar"]')
            nnoremap <F2> :TagbarToggle<CR>
        endif

        " Toggle undo history tree
        nnoremap <F5> :UndotreeToggle<CR>
		map <F6> :setlocal spell! spelllang=en_us<CR>
        " Syntastic - toggle error list. Probably should be toggleable.
        noremap <silent><Leader>lo :Errors<CR>
        noremap <silent><Leader>lc :lclose<CR>

        " EasyAlign - interactive mode (e.g. vipga/gaip)
        xmap ga <Plug>(EasyAlign)
        nmap ga <Plug>(EasyAlign)
    """ }}}
""" }}}
""" Plugin settings {{{
    """ Startify {{{
        let g:startify_bookmarks = [
            \ $HOME . '/.vimrc', $HOME . '/.vimrc.first',
            \ $HOME . '/.vimrc.last', $HOME . '/.vimrc.plugins',
            \  $HOME . '/.config/i3/config',  $HOME . '/.bashrc'
            \ ]
        let g:startify_custom_header = [
            \ '   http://github.com/xelvicon',
            \ ''
            \ ]
        let g:startify_files_number = 5
    """ }}}

    """ CtrlP {{{
        " Don't recalculate files on start (slow)
        let g:ctrlp_clear_cache_on_exit = 0
        let g:ctrlp_working_path_mode = 'ra'

        " Don't split in Startify
        let g:ctrlp_reuse_window = 'startify'
    """ }}}
    """ TagBar {{{
        set tags=tags;/

        " Proportions
        let g:tagbar_left = 0
        let g:tagbar_width = 30

        " Used in lightline.vim
        let g:tagbar_status_func = 'TagbarStatusFunc'
    """ }}}

    """ Syntastic {{{
        " Automatic checking for active, only when :SyntasticCheck for passive
        " NOTE: override these in $HOME/.vimrc.first as needed!
        " https://github.com/timss/vimconf/issues/9
        let g:syntastic_mode_map = get(g:, 'syntastic_mode_map', {
            \ 'mode': 'passive',
            \ 'active_filetypes':
                \ ['c', 'cpp', 'perl', 'python'] })

        " Skip check on :wq, :x, :ZZ etc
        let g:syntastic_check_on_wq = 1
        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*

        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list = 1
        let g:syntastic_check_on_open = 1
        let g:syntastic_check_on_wq = 0
    """ }}}

    """ Netrw {{{
        let g:netrw_banner = 0
        let g:netrw_list_hide = '^\.$'
        let g:netrw_liststyle = 3
    """ }}}
    """ Supertab {{{
        " Complete based on context (compl-omni, compl-filename, ..)
        let g:SuperTabDefaultCompletionType = 'context'

        " Longest common match, e.g. 'b<Tab>' => 'bar' for 'barbar', 'barfoo'
        let g:SuperTabLongestEnhanced = 1
        let g:SuperTabLongestHighlight = 1
    """ }}}
    """ UltiSnips {{{
        let g:UltiSnipsExpandTrigger='<Tab>'
        let g:UltiSnipsJumpForwardTrigger='<Tab>'
        let g:UltiSnipsJumpBackwardTrigger='<S-Tab>'
    """ }}}
    """ Automatically remove preview window after autocomplete {{{
    """ (mainly for clang_complete)
         augroup RemovePreview
            autocmd!
            autocmd CursorMovedI * if pumvisible() == 0 | pclose | endif
            autocmd InsertLeave * if pumvisible() == 0 | pclose | endif
        augroup END
    """ }}}

        let g:ctrlp_status_func = {
            \ 'main': 'CtrlPStatusFunc_1',
            \ 'prog': 'CtrlPStatusFunc_2',
            \ }

        function! TagbarStatusFunc(current, sort, fname, ...) abort
            let g:lightline.fname = a:fname
            return lightline#statusline(0)
        endfunction

        function! s:syntastic()
            SyntasticCheck
            call lightline#update()
        endfunction

        augroup AutoSyntastic
            autocmd!
            execute 'autocmd FileType ' .
                \join(g:syntastic_mode_map['active_filetypes'], ',') .
                \' autocmd BufWritePost <buffer> :call s:syntastic()'
        augroup END
    """ }}}
""" }}}
""" Local ending config, will overwrite anything above. Generally use this. {{{
    if filereadable($HOME.'/.vimrc.last')
        source $HOME/.vimrc.last
    endif
""" }}}

""" autocmd inoremap
""" C programming
"if statement
autocmd FileType c inoremap <Leader>if if()<CR>{<CR><CR>}
"if else statement
autocmd FileType c inoremap <Leader>ife if()<CR>{<CR><CR>}<CR>else<CR>{<CR><CR>}<CR>
"for loop
autocmd FileType c inoremap <Leader>for for(init;<Space>condition;<Space>increment)<CR>{<CR><CR>}

"start nerdtree
autocmd VimEnter * exe 'NERDTree' | wincmd l
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Remove <Tab> from the list of keys mapped by YCM.
let g:ycm_key_list_select_completion = ['<Down>']
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "ᐅ"

"execute pathogen#infect()
"all pathogen#helptags()

let g:Powerline_symbols = "fancy"
let g:Powerline_dividers_override = ["\Ue0b0","\Ue0b1","\Ue0b2","\Ue0b3"]
let g:Powerline_symbols_override = {'BRANCH': "\Ue0a0", 'LINE': "\Ue0a1", 'RO': "\Ue0a2"}
let g:airline_powerline_fonts = 1
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_left_sep = ''

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''



"Airline Themes
"let g:airline_theme='gruvbox'
let g:airline_theme='badwolf'
"let g:airline_theme='ravenpower'
"let g:airline_theme='simple'
"let g:airline_theme='term'
"let g:airline_theme='ubaryd'
"let g:airline_theme='laederon'
"let g:airline_theme='kolor'
"let g:airline_theme='molokai'
"let g:airline_theme='powerlineish'
"
"colorscheme wombat256
"colorscheme tango
"colorscheme railscasts
"colorscheme vividchalk
"colorscheme distinguished
"colorscheme monokai
"colorscheme molokai
"colorscheme neodark
"colorscheme kolor
"colorscheme gotham
"colorscheme jellybeans
"volorscheme desertEx
"colorscheme elflord

"colorscheme 
"let g:gruvbox_contrast_dark ='Hard'
"colorscheme gruvbox

set cursorline
set number
hi CursorLine term=bold cterm=bold guibg=Grey40

let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
