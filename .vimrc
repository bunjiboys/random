" ~/.vimrc, mbp@kolon 11th may 2000

set nowrap              " prevents vim from wrapping when text exceeds the screen
set nocompatible        " vim defaults are much nicer, not compatible with vi
set backspace=2         " allow backspacing over everything in insert mode
set backup              " keep a backup file
set backupdir=~/.vim/backupfiles/   " backup dir
set backupext=~         " backup extension
set history=150         " keep 150 lines of command line history
set ruler               " show the cursor position all the time

set background=dark     " 'light' or 'dark' background

set complete=.,b,u,w,t,i " buffers used for looup in autocompletion

set autowrite

set cinoptions=>1s,e0,n2,}0,^0,:s,=s,ps,t0,(2s,)25,*35,+2s,f0,{0,cs,us
set cinoptions+=g0      " place public/private declarations on row 0
set cinkeys=0{,0},!^F,o,O,e,*<Return>
set comments=s1:/*,mb:*,el:*/,://,b:#,:%,:XCOMM,nb:>,fb:-

set fileformat=unix     " unix file format
set esckeys             " allow cursor keys within insert mode
set cpoptions="aABceFs" " compatible options

set dictionary=/usr/dict/words

set nohlsearch          " highlight search
 
set expandtab           " insert spaces when hitting <tab>
set autoindent          " always autoindent on
set smartindent         " smartindent! :)

" shiftwidth:  Number of spaces to use for each insertion of (auto)indent.
set shiftwidth=4

" When off, a <Tab> always inserts blanks according to 'tabstop'.
set nosmarttab

" The width of a tab, set to 8 so I can actually see where the tabs are
set tabstop=4

"   shortmess:   Kind of messages to show.   Abbreviate them all!
set shortmess=at
"   showcmd:     Show current uncompleted command?  Absolutely!
set showcmd
"   showmatch:   Show the matching bracket for the last ')'?
set showmatch
"   showmode:    Show the current mode?  YES
set showmode

set smartcase

set formatoptions=cqrt

set hidden
set highlight=8r,db,es,hs,mb,Mr,nu,rs,sr,tb,vr,ws
set icon
set incsearch           " search while typing
set ignorecase          " ignore case in searc paterns

set noinsertmode        " don't start in insert mode

"   iskeyword:  Add the dash ('-'), the dot ('.'), and the '@'
"               as "letters" to "words".
"   iskeyword=@,48-57,_,192-255   (default)
set iskeyword=@,48-57,_,192-255,-,.,@-@

set listchars=tab:»·,trail:·

"       laststatus:  show status line?  Yes, always!
set laststatus=2

" lazyredraw:  do not update screen while executing macros
set lazyredraw

"   magic:       use some magic in search patterns?  Certainly!
set magic

"   modeline:    ...
"   Allow the last line to be a modeline - useful when
"   the last line in sig gives the preferred textwidth for replies.
set modeline
set modelines=1
"
set more

set nonumber    " dont show the line number in front of each line

"   pastetoggle - this toggles 'paste' so one can paste text into the terminal
"                 without vim messing the text indenting up.
set pastetoggle=<f11>

"   path:   The list of directories to search when you specify
"           a file with an edit command.
set path=.,~/

"   report: show a report when N lines were changed.
"           report=0 thus means "show all changes"
set report=0

set ruler               " Show cursor position

" use the mouse to visual select something? naaah
" set selectmode=mouse

set shell=/bin/bash

"   suffixes:    Ignore filename with any of these suffixes
"                when using the ":edit" command.
"                Most of these are files created by LaTeX.
set suffixes=.aux,.bak,.dvi,.idx,.log,.ps,.swp,.tar

"   startofline: no:  do not jump to first character with page
"                commands, ie keep the cursor in the current column.
set nostartofline

"   textwidth
set textwidth=9999

"   set title of the terminal
set title

"   ttyfast: are we using a fast terminal?
"            seting depends on where I use Vim...
set ttyfast

"   ttyscroll:      turn off scrolling -> faster!
set ttyscroll=999


set undolevels=1000  " undoing 1000 changes should be enough :-)
set updatecount=200  " write swap file to disk after each 200 characters
set updatetime=6000  " write swap file to disk after 5 inactive seconds

"   viminfo:  What info to store from an editing session
"             in the viminfo file;  can be used at next session.
set viminfo=%,'50,\"100,:100,n~/.viminfo

set noerrorbells        " no freaking error bells
set visualbell

"   t_vb:  terminal's visual bell - turned off to make Vim quiet
set t_vb=

set whichwrap=<,>

"   wrapmargin:
set wrapmargin=1

"   writebackup: yes, make a backup before overwriting a file
set writebackup

" ===================================================================
" MAPpings
" ===================================================================
" Caveat:  Mapping must be "prefix free", ie no mapping must be the
" prefix of any other mapping.  Example:  "map ,abc foo" and
" "map ,abcd bar" will give you the error message "Ambigous mapping".

" The following maps get rid of some basic problems:

" Disable the suspend for ^Z.
map <C-Z> :shell

" map :w to :W, typical typo
nmap :W :w

" ===================================================================
" Editing of email replies and Usenet followups - using autocommands
" ===================================================================

" set the textwidth to 72 characters for replies (email&usenet)
au BufNewFile,BufRead .letter,mutt*,nn.*,snd.* set tw=72
au BufRead /tmp/mutt* normal :g/^> -- $/,/^$/-1d^M/^$^M^L

"
" Part 3 - Change Quoting Level
map ,dp vip:s/^> //<CR>
vmap ,dp    :s/^> //<CR>
"
"   ,qp = quote current inner paragraph (works since vim-5.0q)
"         select inner paragraph
"         then do the quoting as a substitution:
map ,qp   vip:s/^/> /<CR>
"
"    ,qp = quote current paragraph
"          just do the quoting as a substitution:
vmap ,qp   :s/^/> /<CR>

" Changing quote style to *the* true quote prefix string "> ":
"
"    ,kpq kill power quote
vmap ,kpq :s/^> *[a-zA-Z]*>/> >/<C-M>

"     Fix various other quote characters:
"    ,fq "fix quoting"
vmap ,fq :s/^> \([-":}\|][ <C-I>]\)/> > /


" ===================================================================
" Edit your reply!  (Or else!)
" ===================================================================
"
" Part 6  - Inserting Special or Standard Text
" Part 6a - The header
"
" Inserting an ellipsis to indicate deleted text
"
iab  Yell  [...]
vmap ,ell c[...]<esc>


" Put parentheses around "visual text"
"    Used when commenting out an old subject.
"    Example:
"    Subject: help
"    Subject: vim - using autoindent (Re: help)
"
"    ,) and ,( :
vmap ,( v`<i(<ESC>`>a)<ESC>
vmap ,) v`<i(<ESC>`>a)<ESC>
vmap ," c""<left><C-R>"<ESC>
"
" Part 6  - Inserting Special or Standard Text
" Part 6b - End of text - dealing with "signatures".
"
"       remove signatures
"
"   ,kqs = kill quoted sig (to remove those damn sigs for replies)
"        goto end-of-buffer, search-backwards for a quoted sigdashes
"        line, ie "^> -- $", and delete unto end-of-paragraph:
map ,kqs G?^> -- $<CR>d}
" map ,kqs G?^> *-- $<CR>dG
"     ,kqs = kill quoted sig unto start of own signature:
" map ,kqs G?^> *-- $<CR>d/^-- $/<C-M>
"

" Buffer commands (split,move,delete) -
" this makes a little more easy to deal with buffers.
map ,db :bd<C-M>
map ,lb :buffers<C-M>

" Cycle through buffers with ctrl+n and ctrl+p (next and previous)
nnoremap <C-n> :bn<CR>
nnoremap <C-p> :bp<CR>

" Mappings for buffer.vim
map ,b :Buffers<CR>
map ,B :SBuffers<CR>

set pastetoggle=<F9>

" I use this for seeing <Tab>'s in my source code.. and when I find them, kill
" them :)
nmap ,tl :set list<CR>
nmap ,nl :set nolist<CR>

" Load syntax file when vim was compiled with "+syntax"
if has("syntax")
    so $VIMRUNTIME/syntax/syntax.vim
endif

" Folding stuff, enabled for pl, pm, c, h and cpp files.
au BufNewFile,BufRead   *           syn sync fromstart
au BufNewFile,BufRead   *           set foldmethod=manual
au BufNewFile,BufRead   *.c,*.h,*.cpp,*.cc     set foldmethod=syntax
au BufNewFile,BufRead   *.pl,*.pm     set foldmethod=indent
au BufNewFile,BufRead   *.c,*.h,*.cpp,*.cc,*.pl,*.pm     syn region myFold start="{" end="}" transparent fold
au BufNewFile,BufRead   *           set foldlevel=99
au BufNewFile,BufRead   *.html,*.htm    set sw=1
au BufNewFile,BufRead   *.po            set tw=80

au BufNewFile,BufRead   *.hg            set ft=cpp
au BufNewFile,BufRead   *.ccg            set ft=cpp

" latex
map ,rl     :w<CR>:!latex %<CR>
map ,dvi    :w<CR>:silent !xdvi %<.dvi &<CR>
map ,vdvi   ,rl,dvi

" Abbreviations when writing C/C++ code
abbr #i #include
abbr #d #define
abbr #e #endif

" XHTML
"abbr <br> <br />

" create ~/.vim/backupfiles/ if it doesn't exist.
if has("unix")
    if !isdirectory(expand("~/.vim/backupfiles/."))
        !mkdir -p ~/.vim/backupfiles/
    endif
endif

" Stuff which is only possible in vim 6..
if version >= 600

    " Enable automatically filetype indenting and plugins
    filetype plugin indent on

    " source man.vim plugin, this allows me to do ':Man manpage' to read a
    " manpage in vim.
    " so $VIMRUNTIME/ftplugin/man.vim
    " Mapping for explorer.vim, a standard plugin in vim 6
    nmap ,e :Ex<CR>
endif

" Comment out a visually selected block (C++)
vmap C <C-G><C-BS>i/*  */<Left><Left><Left><C-[>p
au BufNewFile,BufRead *.pl,*.pm imap stderr print STDERR "\\n";<ESC>3hi
au BufNewFile,BufRead *.pl,*.pm imap stddump print STDERR Data::Dumper->Dump();<ESC>hi
au BufNewFile,BufRead *.tmpl set filetype=smarty
function! Del()
if getline(".") == getline(line(".") - 1)
   norm dd
endif
endfunction
