"{{{let &colorcolumn=join(range(81,999),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27
"}}}
" 一般設定{{{
" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest
" set filetype on
filetype plugin indent on

" when scrolling, keep cursor 4 lines away from screen border
set scrolloff=4

" 開啟關鍵字上色功能
syntax on
"airline的status bar正常運作，用來設定亞洲字形用幾格來顯示
set ambiwidth=single
" 用空白來當作tab (et)
set noexpandtab
" 定義tab 的空格數 (ts)
set tabstop=4
au FileType python set tabstop=4
au FileType python set noexpandtab
au FileType c,cpp  set expandtab
" 自動縮排所使用的空格數 (sw)
set shiftwidth=4
" 顯示行號
" set nu == set number
set nu
"顯示當前的行號列號
set ruler
"顯示 編輯模式 在左下角的狀態列
set noshowmode
" 尋找時，符合字串會反白表示
set hlsearch
"search 字串時不分大小寫
"set ignorecase == set ic
"set noignorecase == set noic
set ignorecase

"即時搜尋
"set is == set imsearch (immediate)
set is

"設定可以使用backspace
set bs=2

" 游標線
" set cul == set cursorline
set cursorline

" 不和舊式語法相容(相容會仿舊 vi 的 bug)
set nocompatible

"狀態列
set laststatus=2

" Ctrl + N 自動補完會列出待選清單
set showmatch

" vim 裡打指令，按tab 會列出待選列表
set wildmenu

"依文件類型設置自動縮排
"filetype plugin indent on
" C and C++ specific settings (C 語法縮排)
autocmd FileType c,cpp set cindent

"自動縮排
"set ai == set autoindent
set ai

"在狀態欄顯示正在輸入的命令
set showcmd

"設定 w!!，當忘記用sudo 編輯時用w!! 儲存
cmap w!! w !sudo tee %

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" enable 256 colors in vim (this must put before setting the colorscheme)
set t_Co=256
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"background color (put behind colorscheme)
set bg=dark
"set bg=light
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"}}}
"熱鍵設定{{{
"qq離開
map qq :q<CR>
"map儲存
map <F12> <ESC>:w<CR>
"設定paste mode 的切換
function! PasteSwitch()
    if &paste
        set nopaste
    else
        set paste
    endif
endfunction
map <leader>p :call PasteSwitch()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"see :help key-notation
"M(eta) is meta key
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"對視窗切換做map

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"設定換tab
nmap tp :tabprevious<CR>
nmap tn :tabnext<CR>
nmap tt :tabe<SPACE>
nmap ts :tab split<CR>
nmap vs :vs<space>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ignores
set wildignore+=*.o,*.obj,*.pyc " output objects
set wildignore+=*.png,*.jpg,*.gif,*.ico " image format
set wildignore+=*.swf,*.fla " image format
set wildignore+=*.mp3,*.mp4,*.avi,*.mkv " media format
set wildignore+=*.git*,*.hg*,*.svn* " version control system
" set wildignore+=log/**
" set wildignore+=tmp/**
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 自動移除每行最後多餘的空白
"autocmd BufWritePre * :%s/\s\+$//e
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" quick open vimrc in a new tab
nmap <leader>v :tabe ~/.vimrc<CR>
"quick source .vimrc
map <leader>s :source ~/.vimrc<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Return to last edit position when opening files (You want this!)
" 回到上次關閉前的位置
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"當你用 :make , :vimgrep
"之類的指令時，產生的結果會顯示在另外一個新開的視窗，這個視窗就是
"Quickfix，要自己叫出來就得用 :copen , :cclose , :clist 這類指令叫出來
"
"quickfix window toggle function
"from c9s
"leader 一般預設是 \
com! -bang -nargs=? QFix cal QFixToggle(<bang>0)
fu! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        copen 8
        let g:qfix_win = bufnr("$")
    en
endf
nmap <leader>q :QFix<cr>

"map ctrl+n 和ctrl+p
map <C-n> :cnext<CR>
map <C-p> :cprev<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"}}}
"compile鍵{{{

au FileType c   set makeprg=gcc\ -std=c11\ -Wall\ -Wextra\ -pedantic\ -Ofast\ %\ -lm\ -g\ -o\ %:r.out
au FileType cpp set makeprg=g++49\ -std=c++11\ -g\ -Wextra\ -pedantic\ -Ofast\ %\ -lm\ -g\ -o\ %:r.out

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"會依照上面的map
"python時，F9是python3，Ctrl+F9是python2
"au   FileType   c        map   <F9>     :w<CR>:make && ./%:r.out<CR>
"au   FileType   c        map   <F9>     :w<CR>:!gcr<CR>
au   FileType   c,cpp     noremap   <F9>     :w<CR>:make && ./%:r.out<CR>
au   FileType   c,cpp     noremap   <F8>   :w<CR>:!./%:r.out<CR>
au   FileType   python    noremap   <F9>     :w<CR>:!python3   %<CR>
au   FileType   python    noremap   <F8>   :w<CR>:!python2.7   %<CR>
au   FileType   perl      noremap   <F9>     :w<CR>:!perl      %<CR>
au   FileType   go        noremap   <F9>     :w<CR>:!go run      %<CR>
au   FileType   sh       map   <F9>     :w<CR>:!sh        %<CR>
au   FileType   sh       map   <C-F9>   :w<CR>:!bash        %<CR>

"}}}
"other syntax {{{
" Markdown
"au BufNewFile,BufRead *.markdown,*.mdown,*.mkd,*.mkdn,README.md  setf markdown
au BufRead,BufNewFile *.md set filetype=markdown
"}}}
