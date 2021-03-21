"                                          _
"              ____ ___   __  __   _   __ (_)____ ___   _____ _____
"             / __ `__ \ / / / /  | | / // // __ `__ \ / ___// ___/
"            / / / / / // /_/ /   | |/ // // / / / / // /   / /__
"           /_/ /_/ /_/ \__, /    |___//_//_/ /_/ /_//_/    \___/
"                      /____/

"==============================================================================
" INIZIO DELLA CONFIGURAZIONE SENZA PLUGIN
"==============================================================================
" per navigare il file usare il seguente TOC - basta selezionare una keyword,
" premere * per andare alla sezione relativa

" -----------------------------------------------------------------------------
" TOC - CONFIGURAZIONI NON DIPENDENTI DA PLUGIN
" -----------------------------------------------------------------------------

" * configurazione_generale
" * configurazione_gestione_buffers
" * configurazione_wrapping
" * configurazione_autocomplete
" * configurazione_indentazioni
" * configurazione_folding
" * configurazione_toggle_terminale
" * configurazione_spellcheck
" * integrazione_tmux
" * configurazione_search
" * funzioni_indentazione
" * funzioni_per_text_editing
" * funzioni_navigazione
" * funzioni_markdown

" -----------------------------------------------------------------------------
" TOC - PLUGINS
" -----------------------------------------------------------------------------

" * configurazione_lista_plugins
" * configurazione_plugin_slime
" * configurazione_plugin_ipython_cell
" * configurazione_plugin_vimwiki
" * configurazione_plugin_undotree
" * configurazione_plugin_fzf
" * configurazione_plugin_quickscope
" * configurazione_plugin_syntastic
" * configurazione_plugin_lightline

" -----------------------------------------------------------------------------
" COMMENTI GENERALI (senza codice associato)
" -----------------------------------------------------------------------------

" * considerazioni_generali
" * configurazione_tasti_fisici
" * usare_dtach_invece_di_tmux
" * configurazione_bash_terminale
" * discussione_comando_gn
" * discussione_working_directory
" -----------------------------------------------------------------------------
" MAPPING DELLE CHIAVI F#
" -----------------------------------------------------------------------------

" F1 - vim help
" F2 -
" F3 - salta alla posizione quickfix successiva (o precente con shift)
" F4 - fa il toggle del terminale
" F5 - Undo tree toggle
" F6 - apre netrw
" F7 - cambia lo spelling
" F8 - Fa il toggle dei fold
" F9 -
" F10 - fa il toggle del line wrap

" -----------------------------------------------------------------------------
" CONFIGURAZIONE GENERALE
" {configurazione_generale}
" -----------------------------------------------------------------------------

" disattiva la retrocompatibilità con i vecchi vi, opzione fondamentale per
" tutte le nuove features. credo che per neovim sia un default...
set nocompatible

" usa tutti i colori nel terminale
set termguicolors

" attiva i vari plugin per i diversi tipi di file
filetype plugin on

" mette in numeri in modo relativo invece che assoluto. all'inizio sembra
" utile, ma dopo più conveniente avere i numeri assoluti in vista. lo tengo
" commentato per riferimento
" set relativenumber
" mostra i numeri assoluti delle righe del file
set number

" mostra sempre la barra dei tab in alto
set showtabline=2

" se un file viene cambiato dall'esterno di vim, ricaricalo senza fare storie
set autoread

" evidenzia la posizione del cursore sia come linea che come colonna
set cursorline
set cursorcolumn

" attiva la syntax-highlighting
syntax enable

" impone che il default encoding sia l'utf-8
set encoding=utf-8

" attiva il supporto del mouse
set mouse=a

" mostra il comando attivo nella barra inferiore
set showcmd

"di default apre tutti gli split sotto invece che sopra
set splitbelow

" non aggiorna lo schermo mentre esegue le macro, molto più rapido
set lazyredraw

" questo comando carica una riga di testo e la esegue in command mode
" serve per fare test rapidi di configurazioni.
nnoremap <leader>ll yy:<C-r>0<CR>j

" quando la finestra di Vim viene ridimensionata, bilancia di nuovo la
" dimensione relativa degli split (che altrimenti sarebbe sballata)
autocmd VimResized * wincmd =

" questo è un fix per fare in modo che nell'emulatore di terminale il cursore
" sia sempre visibile. Questo è importante perché il cursore del terminale è
" separato da quello di vim ed ogni azione di paste avviene sul cursore del
" terminale!
hi! TermCursorNC ctermfg=15 guifg=#fdf6e3 ctermbg=14 guibg=#93a1a1 cterm=NONE gui=NONE

" configurazione per evitare classici typo premendo i tasti rapidamente
command! W w
command! Wq wq
command! Wqa wqa
command! Q q
command! Qa qa

" visto che cambiare una parola è un'azione molto comune, usa il punto
" non fa conflitto con l'uso del punto per ripetere le azioni
onoremap . iw
xnoremap . iw

" -----------------------------------------------------------------------------
" GESTIONE DEI BUFFER
" {configurazione_gestione_buffers}
" -----------------------------------------------------------------------------

" permette di scambiare fra i buffer in modo più intuitivo
set hidden
" <leader><leader> è più conveniente di <c-^> per scambiare i buffer
nnoremap <leader><leader> <c-^>
" permette di esplorare i buffer list in modo semplice
nnoremap <Leader>b :ls<CR>:b<Space>
" version più avanzata se ci fossero troppi buffer
" per adesso non credo mi serva, ma come riserva per
" il futuro lo tengo qui
" nnoremap <C-e> :set nomore <Bar> :ls <Bar> :set more <CR>:b<Space>

" rimuove automaticamente gli spazi bianchi a fine riga in fase di salvataggio
autocmd BufWritePre * :%s/\s\+$//e

" -----------------------------------------------------------------------------
" CONFIGURAZIONE DEL WRAPPING
" {configurazione_wrapping}
" -----------------------------------------------------------------------------

" attiva il softwrapping alla colonna 80
set wrap
" evita che il wrapping spezzi una parola a metà
set linebreak
" uso F10 per fare il toggle del soft line wrap, non serve proprio sempre...
inoremap <F10> <C-o>:set wrap!<CR>
nnoremap <F10> :set wrap!<CR>
vnoremap <F10> <ESC>:set wrap!<CR>gv
" mette la colonna 80 come colorata in grigio chiaro
set colorcolumn=80
highlight ColorColumn ctermbg=DarkGrey
" questo permette di saltare dalla fine di una linea all'inizio dell'altra
" e viceversa. mi fa comodo per certi mapping.
set whichwrap+=<,>,h,l,[,]
" cerca di tenere sempre almeno 5 righe di spazio sopra e sotto
set scrolloff=5
" scorre laterlmente di un carattere alla volta, un po' più scorrevole
set sidescroll=1
" tiene una distanza fissata dal bordo laterale prima di iniziare a scorrere
set sidescrolloff=15

" Con le frecce mi sposto su e giù dalle righe visive e non reali
inoremap <Up> <C-o>gk
inoremap <Down> <C-o>gj
vnoremap <Up> gk
vnoremap <Down> gj
nnoremap <Up> gk
nnoremap <Down> gj

" questa opzione fa in modo che il testo che viene wrappato sia indentanto
" rispetto al testo originale
set breakindent
" questo determina il grado di intentazione aggiuntiva (4 spazi)
set breakindentopt=shift:4
" questo utilizza un carattere speciale per indicare che si tratta di una
" linea wrappata e non una semplice andata a capo (utile se la linea è lontana
" dal bordo in cui si vedono in numeri)
set showbreak=↳

" -----------------------------------------------------------------------------
" INIZIO CONFIGURAZIONE AUTOCOMPLETAMENTO
" {configurazione_autocomplete}
" -----------------------------------------------------------------------------

" "1. Whole lines                                   |i_CTRL-X_CTRL-L|
" "2. keywords in the current file                  |i_CTRL-X_CTRL-N|
" "3. keywords in 'dictionary'                      |i_CTRL-X_CTRL-K|
" "4. keywords in 'thesaurus', thesaurus-style      |i_CTRL-X_CTRL-T|
" "5. keywords in the current and included files    |i_CTRL-X_CTRL-I|
" "6. tags                                          |i_CTRL-X_CTRL-]|
" "7. file names                                    |i_CTRL-X_CTRL-F|
" "8. definitions or macros                         |i_CTRL-X_CTRL-D|
" "9. Vim command-line                              |i_CTRL-X_CTRL-V|
" "10. User defined completion                      |i_CTRL-X_CTRL-U|
" "11. omni completion                              |i_CTRL-X_CTRL-O|
" "12. Spelling suggestions                         |i_CTRL-X_s|
" "13. keywords in 'complete'                       |i_CTRL-N| |i_CTRL-P|

" gestione dei menù di completamento
" * longest fa in modo che sia completata soltanto la parte più lunga comune a
"   tutte le soluzioni
" * noinsert non inserisce nulla - mi serve se voglio avere un effetto
"   ragionevole quando faccio la correzione ortografica, perché se l'errore è
"   nella prima lettera cancella l'intera parola! non lo includo perché alla
"   fine usare l'autocomplete in insert mode non è comodo...
" * menuone fa in modo che il menu appaia anche quando ho una sola opzione
set completeopt=menuone,noinsert
" questa opzione fa in modo che premere invio selezioni la versione evidenziata
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" questi fanno in modo che l'autocompletamento sia progressivo e ci sia sempre
" una opzione pronta ad essere selezionata
" completamento parole dal file locale e dal dizionario (entrambi)
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" completamento parole dal file
inoremap <expr> <C-x><C-n> pumvisible() ? '<C-n>' : '<C-x><C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" completamento del nome dei file
inoremap <expr> <C-x><C-f> pumvisible() ? '<C-n>' : '<C-x><C-f><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
" Ctrl-l line completion
" Ctrl-k dal dizionario
" Ctrl-o omnicomplete
" Ctrl-p completamento inverso a C-n (parte dal basso)

" dizionari delle lingue in uso...
set dictionary+=/usr/share/dict/american-english
set dictionary+=/usr/share/dict/italian
" di default quando premo C-n include anche anche la ricerca dai dizionari
" (di default farebbe soltanto quella dai buffer)
set complete+=k

" questo dovrebbe dare l'autocomplete per python
" CTRL+X followed by CTRL+O
" funziona soltanto con le librerie installate di sistema, non con quelle
" locali. per quelli devo usare i tags fatti con ctags
set omnifunc=syntaxcomplete#Complete

" questa opzione è utile in combinazione con smartcase per le ricerche
" in questo modo quando attivo l'autocomplete, il completamente è case
" sensitive. se non lo faccio rischio che le proposte mi cambino il case della
" parola facendo poi dei gran casini!
set infercase

" imposta l'altezza massima di visualizzazione del menu a 10 caratteri
set pumheight=10



" -----------------------------------------------------------------------------
" CONFIGURAZIONE DELLE SPELLCHECK
" {configurazione_spellcheck}
" -----------------------------------------------------------------------------

" normalmente imposterei il linguaggio con i seguenti comandi:
" set spell spelllang=it,en_us"
" set spell
" però ho una funzione per fare il toggle fra italiano, inglese, e nulla.
" breve remind dei comandi per lo spellcheck:
" * `[s` e `]s` scorrono la lista degli errori
" * `z=` apre la lista dei suggerimenti (scorre con <C-n> e <C-p>)
" * `zg` e `zw` aggiungono la parola al dizionario di riferimento. se ho
"   sbagliato ad inserire posso usare `zug` e `zuw`

" complicata funzione per fare lo swap fra i vari tipi di spell cheking
setlocal nospell
let g:myLangList = ['nospell', 'it', 'en_gb']
let g:myLang=0
function! ToggleSpell()
  let g:myLang=g:myLang+1
  if g:myLang>=len(g:myLangList) | let g:myLang=0 | endif
  if g:myLang==0
    setlocal nospell
  else
    execute "setlocal spell spelllang=".get(g:myLangList, g:myLang)
  endif
  echo "spell checking language:" g:myLangList[g:myLang]
endfunction

nnoremap <silent> <F7> :call ToggleSpell()<CR>
inoremap <silent> <F7> <C-o>:call ToggleSpell()<CR>
vnoremap <silent> <F7> :call ToggleSpell()<CR>

" l'altra opzione sarebbe anche "best", ma usa la distanza fonetica inglese
" fa vedere soltanto 10 suggerimenti
set spellsuggest=fast,10


" -----------------------------------------------------------------------------
" CONFIGURAZIONE DELLE INDENTAZIONI
" {configurazione_indentazioni}
" -----------------------------------------------------------------------------

" in modalità di edit, andando a capo, la linea successiva viene indentata
" nello stesso modo di quella precedente
set autoindent
" se un carattere di tabulazione è presente, rappresentalo con 4 spazi
set tabstop=4
" It's used to indicate the number of characters in each level when you"
" press >> (increase one level of indentation),
" << (cancel one level of indentation),"
" or == (cancel all indentations) on the text."
" la quantità di cui deve indentare con i comandi di indentazione automatica.
" le chiavi di azione sono [<>=]. in particolare >> e << cambiano
" l'indentazione di una linea di un livello, == la rimuove del tutto.
" =<movement> fa l'autoindent del codice
set shiftwidth=4
" rimpiazza i Tab con gli spazi... guerre di religione che si scatenano
set expandtab
" quanti spazi devo uasre per rimpiazzare il singolo carattere di tabulazione
set softtabstop=4
" con tab faccio l'indentazione e Shift-Tab la rimuove
" funziona in modalità visiva e normale
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
nnoremap <Tab> >>
nnoremap <S-Tab> <<

" -----------------------------------------------------------------------------
" CONFIGURAZIONE DELLA RICERCA
" {configurazione_search}
" -----------------------------------------------------------------------------
" The other corresponding parenthesis, square bracket, and brace will be
" highlighted automatically when the cursor encounters one parenthesis,
" square bracket, and brace.
set showmatch
" Highlight the match when searching.
set hlsearch
" Each time you enter a character, it will jump
" to the result of the first match automatically.
set incsearch
" Case will be ignored when searching.
set ignorecase
" per rimuovere gli highlight dopo una ricerca mi basta premere spazio
nnoremap <silent> <Space> :noh<CR>
" If the ignorecase is on at the same time, it will be case sensitive
" to the search term with only one uppercase letter; otherwise,
" it will be case insensitive. For example, when searching for Test,
" it will not match test; but when searching for test, it will match Test.
set smartcase
" Do not make any noise when an error occurs.
set noerrorbells
" When an error occurs, a visual cue will be given,
" which usually is the screen flickers.
set visualbell
" quando faccio una sostituzione mi fa una preview live, ed apre uno split in
" cui mi fa vedere le linee che non si vedono a schermo
" se non voglio lo split basta mettere `nosplit`
set inccommand=split
" fa partire la ricerca in modo normale ma la restringe soltanto al testo
" evidenziato, non esce oltre
vnoremap / <Esc>/\%V

" -----------------------------------------------------------------------------
" CONFIGURAZIONE DEL FOLDING
" {configurazione_folding}
" -----------------------------------------------------------------------------

" zf - crea un nuovo fold
" za - toggle fra aperto e chiuso
" zc, zo, za - chiude, apre o fa il toggle su di un fold
" zC, zO, zA - fanno lo stesso ma a livello di intero documento
" zm, zr - aumenta o riduce il livello di folding in tutto il documento di 1
" zM, zR - aprono o chiudono tutte le fold completamente

" Fold based on indention levels.
" set foldmethod=manual
set foldmethod=manual
" imposta una piccola barra laterale che visualizza le fold
set foldcolumn=2
" imposta il livello di default del fold. in questo modo i primi due livelli
" sono sempre aperti.
set foldlevel=2
" usa F8 per fare il toggle dei fold
inoremap <F8> <C-O>za
nnoremap <F8> za
onoremap <F8> <C-C>za
vnoremap <F8> zf
" setta il livello di indentazione
nnoremap z1  :set foldlevel=0<CR><Esc>
nnoremap z2  :set foldlevel=1<CR><Esc>
nnoremap z3  :set foldlevel=2<CR><Esc>
nnoremap z4  :set foldlevel=3<CR><Esc>
nnoremap z5  :set foldlevel=4<CR><Esc>
nnoremap z6  :set foldlevel=5<CR><Esc>
nnoremap z7  :set foldlevel=6<CR><Esc>
nnoremap z8  :set foldlevel=7<CR><Esc>
nnoremap z9  :set foldlevel=8<CR><Esc>

" preferesco il folding manuale ma spesso è comodo avere quello con
" l'indentazione.
nnoremap zmi  :set foldmethod=indent<CR>
nnoremap zmm  :set foldmethod=manual<CR>
nnoremap zms  :set foldmethod=syntax<CR>

" questo comando setta il tipo di folding di default per i file python a
" quello di indentazione. non sono un gran fan, devo dire...
au BufNewFile,BufRead *.py set foldmethod=indent

" il viewoptions serve per non cambiare directory quando lo faccio
set viewoptions-=options

" -----------------------------------------------------------------------------
" TOGGLE DEL TERMINALE
" {configurazione_toggle_terminale}
" -----------------------------------------------------------------------------

function! ChooseTerm(termname, slider)
    let pane = bufwinnr(a:termname)
    let buf = bufexists(a:termname)
    if pane > 0
        " pane is visible
        if a:slider > 0
            :exe pane . "wincmd c"
        else
            :exe "e #"
        endif
    elseif buf > 0
        " buffer is not in pane
        if a:slider
            :exe "topleft split"
        endif
        :exe "buffer " . a:termname
    else
        " buffer is not loaded, create
        if a:slider
            :exe "botright split"
        endif
        :terminal
        :exe "f " a:termname
    endif
endfunction
" Toggle 'default' terminal
nnoremap <F4> :call ChooseTerm("term-slider", 1)<CR>A
inoremap <F4> <Esc>:call ChooseTerm("term-slider", 1)<CR>A
vnoremap <F4> <Esc>:call ChooseTerm("term-slider", 1)<CR>A
" il terminale va in in sleep se faccio solo :q - il buffer rimane vivo ed
" attivo e lo posso mostrare di nuovo in un altro split/tab
tnoremap <F4>  <C-\><C-n>:q<CR>
" Start terminal in current pane
" nnoremap <M-CR> :call ChooseTerm("term-pane", 0)<CR>
" permette di uscire dalla modalità terminale con esc, anche se in realtà
" servirebbe un'altra combinazione di chiavi...
tnoremap <Esc> <C-\><C-n>

" questa funzione non è per lo split ma non sono sicuro di dove metterla.
" questo mapping mi permette di incollare dai registri di neovim mentre faccio
" edit del terminal usando <Alt-r> nello stesso modo in cui in vim uso <C-r>.
" Nel terminale questo è impostato per la ricerca nella history, e non voglio
" oscurarlo.
tnoremap <expr> <A-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" -----------------------------------------------------------------------------
" INTEGRAZIONE CON TMUX
" {integrazione_tmux}
" -----------------------------------------------------------------------------

" Easy window navigation with tmux integration
function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction

if exists('$TMUX')
    " normal mode
    nnoremap <silent> <M-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
    nnoremap <silent> <M-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
    nnoremap <silent> <M-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
    nnoremap <silent> <M-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
    " insert mode
    inoremap <silent> <M-h> <ESC>:call TmuxOrSplitSwitch('h', 'L')<cr>
    inoremap <silent> <M-j> <ESC>:call TmuxOrSplitSwitch('j', 'D')<cr>
    inoremap <silent> <M-k> <ESC>:call TmuxOrSplitSwitch('k', 'U')<cr>
    inoremap <silent> <M-l> <ESC>:call TmuxOrSplitSwitch('l', 'R')<cr>
    " visual mode
    vnoremap <silent> <M-h> :call TmuxOrSplitSwitch('h', 'L')<cr>
    vnoremap <silent> <M-j> :call TmuxOrSplitSwitch('j', 'D')<cr>
    vnoremap <silent> <M-k> :call TmuxOrSplitSwitch('k', 'U')<cr>
    vnoremap <silent> <M-l> :call TmuxOrSplitSwitch('l', 'R')<cr>
    " terminal mode
    tnoremap <silent> <M-h> <C-\><C-n>:call TmuxOrSplitSwitch('h', 'L')<cr>
    tnoremap <silent> <M-j> <C-\><C-n>:call TmuxOrSplitSwitch('j', 'D')<cr>
    tnoremap <silent> <M-k> <C-\><C-n>:call TmuxOrSplitSwitch('k', 'U')<cr>
    tnoremap <silent> <M-l> <C-\><C-n>:call TmuxOrSplitSwitch('l', 'R')<cr>
else
    " normal mode
    nnoremap <M-h> <C-w>h
    nnoremap <M-j> <C-w>j
    nnoremap <M-k> <C-w>k
    nnoremap <M-l> <C-w>l
    " visual mode
    vnoremap <M-h> <C-w>h
    vnoremap <M-j> <C-w>j
    vnoremap <M-k> <C-w>k
    vnoremap <M-l> <C-w>l
    " insert mode
    inoremap <M-h> <ESC><C-w>h
    inoremap <M-j> <ESC><C-w>j
    inoremap <M-k> <ESC><C-w>k
    inoremap <M-l> <ESC><C-w>l
    " terminal mode
    tnoremap <M-h>  <C-\><C-n><C-w>h
    tnoremap <M-j>  <C-\><C-n><C-w>j
    tnoremap <M-k>  <C-\><C-n><C-w>k
    tnoremap <M-l>  <C-\><C-n><C-w>l
endif

" fa uno split orizzontale
nnoremap <M-_> <C-w>s
" fa uno split verticale
nnoremap <M-\|> <C-w>v
" ruota fra gli split come un alt-tab fra le finestre
nnoremap <M-w> <C-w>w
" chiude tutti gli split a parte quello attivo
nnoremap <M-o> :only<CR>

" posta lo split nella direzione corrispondente
nnoremap <M-H> <C-w>H
nnoremap <M-J> <C-w>J
nnoremap <M-K> <C-w>K
nnoremap <M-L> <C-w>L

nnoremap <M-Right> <C-w>>
nnoremap <M-Left> <C-w><
nnoremap <M-Up> <C-w>+
nnoremap <M-Down> <C-w>-

" -----------------------------------------------------------------------------
" FUNZIONI DI TEXT EDITING
" {funzioni_per_text_editing}
" -----------------------------------------------------------------------------

" imposta come registro di default per copiare quello di sistema
set clipboard=unnamedplus

" mapping emacs style per andare ad inizio e fine riga durante l'edit
" ricordo che
" * <c-u> cancella dall'inizio della riga fino alla posizione attuale
" * <c-w> cancella fino all'inizio della parola corrente
" * <C-t> indenta, <C-d> de-indenta
inoremap <C-e> <C-o>A
inoremap <C-a> <C-o>I
inoremap <C-f> <C-o>ce
" temporaneamente disabilitato per conflitto con il comando per autocomplete
" inoremap <C-l> <C-o>S

" shortcut nella modalità comandi
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" questo è un mapping personalizzato per appendere al termine di una parola
" le lettere minuscole mi vanno ad inizio e fine di una 'word'
" le lettere maiuscole vanno ad inizio e fine di una 'WORD'
nnoremap <Leader>a /.\><CR>:noh<CR>a
nnoremap <Leader>A /. <CR>:noh<CR>a
nnoremap <Leader>i ?\<.<CR>:noh<CR>i
nnoremap <Leader>I ? .<CR>:noh<CR>li

" sposto blocchi di testo
" potrei aggiustare l'indentazione appendndo `==`
nnoremap <C-Down> :m .+1<CR>
nnoremap <C-Up> :m .-2<CR>
inoremap <C-Down> <Esc>:m .+1<CR>gi
inoremap <C-Up> <Esc>:m .-2<CR>gi
vnoremap <C-Down> :m '>+1<CR>gv
vnoremap <C-Up> :m '<-2<CR>gv

" copia fino alla fine della riga, in modo simile a C, S e D
nnoremap Y y$
" K nativamente farebbe la ricerca nel manuale, ma non mi interessa molto
" lo uso come inverso di J, per dividere le linee sul prossimo punto
" per essere proprio simmetrici dovrei rimuovere solo con due spazi, ma:
" 1) questo è un comando per aggiusta testo copia, e raramente ho i due spazi
" 2) se per caso sbaglio posso annullare facilmente con X
nnoremap K :.s/\([\.?!:;]\) \+/\1\r/<CR>
nnoremap X kJ

" Q passerebbe in modalità Ex, in cui non aggiorna più lo schemo come se
" stessi usando ed. Non c'è una valida ragione al mondo se non per essere
" noiosi per attivarla. una valida sostituzione è usare la Q per ripetere
" l'ultima macro (assume sia la q, per facilità)
nnoremap Q @q
" in modalità visiva applica la macro a tutto
vnoremap Q :normal @q<cr>

" lancia un comando in modalità normale sulla zona evidenziata
" (la zona evidenziata come range viene inserita automaticamente dal sistema)
vnoremap n :normal<Space>
" lancia il comando di sostituzione limitato all'area in questione.
" segue anche le configurazione indicate dalla sezione sulla ricerca
vnoremap s :s/

" premenendo \s passo in modalità sostituzione della parola o selezione sotto
" il cursore. avendo anche la preview live in pratica si comporta come i
" cursori multipli di sublime (o almeno una buona approssimazione)
nnoremap <Leader>s :let @s=expand('<cword>')<CR>:%s/\<<C-r>s\>/<C-r>s/g<Left><Left>
xnoremap <Leader>s "sy:%s/<C-r>s/<C-r>s/g<Left><Left>

" questo sarebbe la ricerca per WORD invece che word, ma richiede di  fare un
" escape che non è banale e non ho ancora risolto, la funzione sotto dovrebbe
" essere quella necessaria
" nnoremap <Leader>S :let @s=expand('<cWORD>')<CR>:%s/\V\<<C-r>s\>/<C-r>s/g<Left><Left>
" escape(expand('<cword>'), '/\')

" imposto per fare la conversione da markdown a latex, ma si può cambiare
" permette di convertire in modo rapido un pezzo di testo usando
"   gq{motion} oppure gw{motion}
" gq sposta il cursore, gw invece lo lascia al suo posto
" e per editare dei testi in latex è una manna dal cielo!
au FileType latex let &formatprg="pandoc --from markdown --to latex"

" questo invece mi imposta black come formattatore automatico del comando `=`
" quindi `==` riformatta una linea usando black.
" let &equalprg="black --quiet --target-version py39 -"
au FileType python let &formatprg="black --quiet --target-version py38 -"

" imposta un limite ristretto per i file di commit di git
au FileType gitcommit set tw=68

" quando faccio una copia mi fa un breve flash per darmi un feedback visivo di
" che cosa abbia copiato
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END

" permette di farebackspace in modo conscio delle indentazioni, interruzioni
" di linea e punto di inserimento
set backspace=indent,eol,start
" ogni spazio crea un nuovo branch di undo e quindi gli undo annullano una
" parola alla volta invece dell'intero edit
" per adesso lo rimuovo perché altrimenti la storia degli edit diventa troppo
" complessa!
" inoremap <Space> <Space><C-g>u


" permette di gestire i file di undo in modo permanente fra le varie sessioni

if has('persistent_undo')
  " define a path to store persistent_undo files.
  let target_path = expand('~/.undodir/')
  " create the directory and any parent directories
  " if the location does not exist.
  if !isdirectory(target_path)
    call system('mkdir -p ' . target_path)
  endif
  " point Vim to the defined undo directory.
  let &undodir = target_path
  " finally, enable undo persistence.
  set undofile
endif

" inserisce la data corrente in formato ISO ed appende del testo a seguire
" mi serve per ledger
nnoremap <Leader>do "=system("date -I \| tr -d '\n'")<CR>p
inoremap <M-o> <C-r>=system("date -I \| tr -d '\n'")<CR>

" funzioni per aumentare la prima data sulla linea di un giorno o ridurala di
" uno, sfrutta la funzione date di bash
" date --date="2011-01-13+1days" -I
nnoremap <M-a> :.s/\(\<\d\{4}-\d\{2}-\d\{2}\)/\=system('date -I --date="'.submatch(0).'+1days" \|tr -d "\n" ')/<CR>:noh<CR>
nnoremap <M-x> :.s/\(\<\d\{4}-\d\{2}-\d\{2}\)/\=system('date -I --date="'.submatch(0).'-1days" \|tr -d "\n" ')/<CR>:noh<CR>

" chiude automaticamente le parentesi aperte ed altri caratteri
" il comando <C-g>U serve per evitare di rompere la sequenza di undo
inoremap ( ()<C-g>U<Left>
inoremap [ []<C-g>U<Left>
inoremap { {}<C-g>U<Left>

" queste funzioni mi servono per aprire parentesi ed andare a capo
" se non premo invio ed inizio a scrivere mi completa l'altra parentesi
" come nel caso precedente, altrimenti mi va a capo, mi allinea la parentesi
" con la riga madre e mi indenta, il tutto senza rompere la catena di undo.
inoremap {<CR> {<CR>_<CR>}<C-o><<<C-g>U<Up><C-o>^<Del>
inoremap (<CR> (<CR>_<CR>)<C-o><<<C-g>U<Up><C-o>^<Del>
inoremap [<CR> [<CR>_<CR>]<C-o><<<C-g>U<Up><C-o>^<Del>

" questo mapping evita di richiudere più volte una parentesi se per sbaglio la
" ripeto. In questo modo evito di incasinarmi.
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<C-g>U<Right>" : ")"
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<C-g>U<Right>" : "]"
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<C-g>U<Right>" : "}"

" mapping equivalenti per le virgolette, non sono ancora sicuro se usarli o no
inoremap ' ''<C-g>U<Left>
inoremap " ""<C-g>U<Left>
inoremap ` ``<C-g>U<Left>
"
" visto che le virgolette non hanno aperture e chiusura, non è immedato
" riconoscere quando sono doppie...
" inoremap <expr> '  strpart(getline('.'), col('.')-1, 1) == "'" ? "\<C-g>U<Right>" : "''<C-g>U<Left>"

" questo è un mapping teorico per rimpiazzare il doppio doppio apice con gli
" apici "fancy"
" inoremap '' ‘’<C-g>U<Left>
" inoremap "" “”<C-g>U<Left>

" questa funzione mi elimina le coppie quando sono vuote e faccio
" backspace
function s:remove_pair() abort
  let pair = getline('.')[ col('.')-2 : col('.')-1 ]
  return stridx('""''''()[]<>{}', pair) % 2 == 0 ? "\<del>\<c-h>" : "\<bs>"
endfunction

inoremap <expr> <bs> <sid>remove_pair()
imap <c-h> <bs>

" questo mi permette di avvolgere una selezione con un marker
" di default mantiene la stessa selezione di prima.
" se uso le parentesi chiuse seleziona anche le parentesi
vnoremap -( <Esc>`>a)<Esc>`<i(<Esc>gvlol
vnoremap -) <Esc>`>a)<Esc>`<i(<Esc>gvll
vnoremap -[ <Esc>`>a]<Esc>`<i[<Esc>gvlol
vnoremap -] <Esc>`>a]<Esc>`<i[<Esc>gvll
vnoremap -{ <Esc>`>a}<Esc>`<i{<Esc>gvlol
vnoremap -} <Esc>`>a}<Esc>`<i{<Esc>gvll
vnoremap -< <Esc>`>a><Esc>`<i<<Esc>gvlol
vnoremap -> <Esc>`>a><Esc>`<i<<Esc>gvll
vnoremap -" <Esc>`>a"<Esc>`<i"<Esc>gvlol
vnoremap -' <Esc>`>a'<Esc>`<i'<Esc>gvlol
vnoremap -` <Esc>`>a`<Esc>`<i`<Esc>gvlol

" questo remap mi permette di muovermi durante l'edit senza rompere l'undo
inoremap <Right> <C-g>U<Right>
inoremap <Left> <C-g>U<Left>
inoremap <C-Right> <C-g>U<C-Right>
inoremap <C-Left> <C-g>U<C-Left>

" aggiungono una riga sopra o sotto il cursore, ma rimangono in normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" funzione rubata dal plugin vim-ninja per inserire o appendere dopo un
" movimento/text object
" https://github.com/tommcdo/vim-ninja-feet
function! s:ninja_insert(mode)
	let op = a:mode == 'line' ? 'O' : 'i'
	call feedkeys('`['.op, 'n')
endfunction

function! s:ninja_append(mode)
	let op = a:mode == 'line' ? 'o' : 'a'
	call feedkeys('`]'.op, 'n')
endfunction

nnoremap <silent> <Plug>(ninja-insert) :<C-U>set operatorfunc=<SID>ninja_insert<CR>g@
nnoremap <silent> <Plug>(ninja-append) :<C-U>set operatorfunc=<SID>ninja_append<CR>g@

" non so per quale motivo è necessario fare il mapping completo, o non
" funziona...
nmap z[ <Plug>(ninja-insert)
nmap z] <Plug>(ninja-append)

"------------------------------------------------------------------------------
" FUNZIONE PER LA NAVIGAZIONE
" {funzioni_navigazione}
"------------------------------------------------------------------------------

" salta alla riga e colonna data
" gf salta al file
" gF salta al file alla riga data
" \f salta a file, riga e colonna fname:r:c
" se metto un terzo valore mi indica quanti caratteri seleziona dopo quello
" indicato. grazie al wrapping dei tasti direzionali (in particolare la l)
" questo mi permette selezioni multilinea
" ~/.config/nvim/init.vim
" ~/.config/nvim/init.vim:219
" ~/.config/nvim/init.vim:219:3
" ~/.config/nvim/init.vim:208:0:9 qui c'è una definizione di funzione
function! GoToColumnInFile (fileInfoString)
  let fileInfo = split(a:fileInfoString, ":")
  let column = 0
  normal! gF
  if len(fileInfo) > 2
    let column = fileInfo[2]
    execute 'normal! ' . column . '|'
  endif
  if len(fileInfo) > 3
    let selection = fileInfo[3]
    execute 'normal! v' . selection . 'l'
  endif
endfunction
nnoremap <leader>f :call GoToColumnInFile(expand("<cWORD>"))<CR>



" gestione migliorata di gx
" il primo fa in modo che prenda tutto il path anche con caratteri strani
" il secondo serve perché in modalità visuale (che serve quando la WORD prende
" male) di default copia con Curl e poi apre nel browser.
" in questo modo invece usa il registo `u` per eseguire un comando in Ex mode.
" le virgolette intorno al URL servono per evitare alcuni caratteri strani,
" xdg-open accetta una stringa senza problemi.
" ovviamente essendo basato su xdg-open è specifico di linux
let g:netrw_gx="<cWORD>"
vnoremap gx "uy:!xdg-open "<C-R>u"<CR>

" fuzzy finder senza plugins - processo sincrono
" attenzione a quale cartella si sceglie perché nella home si pianta...
" 1. fornisce il completamento con tab per quanto riguarda
" i files, e ricerca in tutte le sottodirectory
set path+=**
" 2. mostra tutti i file che corrispondono alla ricerca in modo live
set wildmenu
" ignora le directory problematiche come miniconda ed affini
" set wildignore+=**/node_modules/**
set wildignore+=*/node_modules/*,_site,*/__pycache__/,*/venv/*,*/target/*
set wildignore+=*/.vim$,\~$,*/.log,*/.aux,*/.cls,*/.aux,*/.bbl,*/.blg,*/.fls
set wildignore+=*/.fdb*/,*/.toc,*/.out,*/.glo,*/.log,*/.ist,*/.fdb_latexmk
set wildignore+=*/miniconda*

" apre il file browser, netrw
nnoremap <F6> :Explore<CR>

" map <F3> and <S-F3> to jump between locations in a quickfix list, or
" differences if in window in diff mode
nnoremap <expr> <silent> <F3>   (&diff ? "]c" : ":cnext\<CR>")
nnoremap <expr> <silent> <S-F3> (&diff ? "[c" : ":cprev\<CR>")

" Configura Vim per usare griprep se disponibile
" per usarlo posso fare :grep! <pattern> | copen
" oppure :lgrep! <patter> | lopen
" (il copen serve per aprire subito la quickfix))
" (lgrep apre una location list, locale del buffer, ed usa lopen)
" (il punto esclamativo evita di andare al primo risultato immediatamente)
if executable('rg')
   set grepprg=rg\ --vimgrep\ --max-columns\ 80
   set grepformat=%f:%l:%c:%m
endif

" questo comando associa il programma mypy al comando `:make`.
" quando viene eseguito crea una quickfix list, ma di default è chiusa
" e va aperta con `:copen`. inoltre di default salta subito al primo elemento.
" se lo si vuole evitare bisogna usare `:make!`
" `:lmake` crea una location list invece di una quickfix
" se ho un errore di sintassi mypy si rifiuta di compilare!
au FileType python let &makeprg="mypy --strict %"

au FileType python nnoremap <leader>cmp  :let &makeprg="mypy --strict % "<CR>
au FileType python nnoremap <leader>cpl  :let &makeprg="pylint --output-format=parseable % "<CR>
au FileType python nnoremap <leader>csm  :let &makeprg="snakemake -j1 "<CR>

" nota su make: se ho un makefile posso anche lasciare il make di default (o
" magari usare snakemake) ed indicare la regola che voglio usare! ovviamente
" se non mi riempe la quickfix poi non posso usarlo per correggere il codice.

" questi due comandi vengono eseguito automaticamente quando creo una nuova
" quickfix list e la aprono automaticamete.
" Vale sia per le quickfix che le location list (posso avere una sola
" quicklist ma varie location lists)
autocmd QuickFixCmdPost [^l]* nested copen
autocmd QuickFixCmdPost    l* nested lopen

" comando su come aprire il buffer a cui una quickfix fa riferimento.
" adesso considera se è già aperto in uno split, oppure in un altro tab, ed
" eventualmente si sposta su quelli, altrimenti apre un nuovo split.
" in caso contrario si può usare anche l'opzione `newtab` per aprire il buffer
" in un nuovo tab.
set switchbuf=useopen,usetab,split


"------------------------------------------------------------------------------
" FUNZIONE PER SELEZIONARE DENTRO INTENDETAZIONE ii ed ai
" {funzioni_indentazione}
"------------------------------------------------------------------------------

function! s:inIndentation()
	" select all text in current indentation level excluding any empty lines
	" that precede or follow the current indentationt level;
    "
	" magic is needed for this
	let l:magic = &magic
	set magic
	" move to beginning of line and get virtcol (current indentation level)
	" BRAM: there is no searchpairvirtpos() ;)
	normal! ^
	let l:vCol = virtcol(getline('.') =~# '^\s*$' ? '$' : '.')
	" pattern matching anything except empty lines and lines with recorded
	" indentation level
	let l:pat = '^\(\s*\%'.l:vCol.'v\|^$\)\@!'
	" find first match (backwards & don't wrap or move cursor)
	let l:start = search(l:pat, 'bWn') + 1
	" next, find first match (forwards & don't wrap or move cursor)
	let l:end = search(l:pat, 'Wn')

	if (l:end !=# 0)
		" if search succeeded, it went too far, so subtract 1
		let l:end -= 1
	endif
	" go to start (this includes empty lines) and--importantly--column 0
	execute 'normal! '.l:start.'G0'
	" skip empty lines (unless already on one .. need to be in column 0)
	call search('^[^\n\r]', 'Wc')
	" go to end (this includes empty lines)
	execute 'normal! Vo'.l:end.'G'
	" skip backwards to last selected non-empty line
	call search('^[^\n\r]', 'bWc')
	" go to end-of-line 'cause why not
	normal! $o
	" restore magic
	let &magic = l:magic
endfunction


function! s:aroundIndentation()
	" select all text in the current indentation level including any emtpy
	" lines that precede or follow the current indentation level;

	" magic is needed for this (/\v doesn't seem work)
	let l:magic = &magic
	set magic
	" move to beginning of line and get virtcol (current indentation level)
	" BRAM: there is no searchpairvirtpos() ;)
	normal! ^
	let l:vCol = virtcol(getline('.') =~# '^\s*$' ? '$' : '.')
	" pattern matching anything except empty lines and lines with recorded
	" indentation level
	let l:pat = '^\(\s*\%'.l:vCol.'v\|^$\)\@!'
	" find first match (backwards & don't wrap or move cursor)
	let l:start = search(l:pat, 'bWn') + 1

	" NOTE: if l:start is 0, then search() failed; otherwise search() succeeded
	"       and l:start does not equal line('.')
	" FORMER: l:start is 0; so, if we add 1 to l:start, then it will match
	"         everything from beginning of the buffer (if you don't like
	"         this, then you can modify the code) since this will be the
	"         equivalent of "norm! 1G" below
	" LATTER: l:start is not 0 but is also not equal to line('.'); therefore,
	"         we want to add one to l:start since it will always match one
	"         line too high if search() succeeds

	" next, find first match (forwards & don't wrap or move cursor)
	let l:end = search(l:pat, 'Wn')

	" NOTE: if l:end is 0, then search() failed; otherwise, if l:end is not
	"       equal to line('.'), then the search succeeded.
	" FORMER: l:end is 0; we want this to match until the end-of-buffer if it
	"         fails to find a match for same reason as mentioned above;
	"         again, modify code if you do not like this); therefore, keep
	"         0--see "NOTE:" below inside the if block comment
	" LATTER: l:end is not 0, so the search() must have succeeded, which means
	"         that l:end will match a different line than line('.')

	if (l:end !=# 0)
		" if l:end is 0, then the search() failed; if we subtract 1, then it
		" will effectively do "norm! -1G" which is definitely not what is
		" desired for probably every circumstance; therefore, only subtract one
		" if the search() succeeded since this means that it will match at least
		" one line too far down
		" NOTE: exec "norm! 0G" still goes to end-of-buffer just like "norm! G",
		"       so it's ok if l:end is kept as 0. As mentioned above, this means
		"       that it will match until end of buffer, but that is what I want
		"       anyway (change code if you don't want)
		let l:end -= 1
	endif
	" finally, select from l:start to l:end
	execute 'normal! '.l:start.'G0V'.l:end.'G$o'
	" restore magic
	let &magic = l:magic
endfunction

" "in indentation" (indentation level sans any surrounding empty lines)
xnoremap <silent> ii :<c-u>call <sid>inIndentation()<cr>
onoremap <silent> ii :<c-u>call <sid>inIndentation()<cr>

" "around indentation" (indentation level and any surrounding empty lines)
xnoremap <silent> ai :<c-u>call <sid>aroundIndentation()<cr>
onoremap <silent> ai :<c-u>call <sid>aroundIndentation()<cr>


"------------------------------------------------------------------------------
" FUNZIONE PER SELEZIONARE DENTRO SEZIONI DI MARKDOWN
" {funzioni_markdown}
"------------------------------------------------------------------------------


"" Markdown header text object
" * inner object is the text between prev section header(excluded) and the next
"   section of the same level(excluded) or end of file.
" * an object is the text between prev section header(included) and the next section of the same
"   level(excluded) or end of file.
func! s:header_textobj(inner) abort
    let lnum_start = search('^#\+\s\+[^[:space:]=]', "ncbW")
    if lnum_start
        let lvlheader = matchstr(getline(lnum_start), '^#\+')
        let lnum_end = search('^#\{1,'..len(lvlheader)..'}\s', "nW")
        if !lnum_end
            let lnum_end = search('\%$', 'cnW')
        else
            let lnum_end -= 1
        endif
        if a:inner && getline(lnum_start + 1) !~ '^#\+\s\+[^[:space:]=]'
            let lnum_start += 1
        endif

        exe lnum_end
        normal! V
        exe lnum_start
    endif
endfunc


onoremap <buffer><silent> ih :<C-u>call <sid>header_textobj(v:true)<CR>
onoremap <buffer><silent> ah :<C-u>call <sid>header_textobj(v:false)<CR>
xnoremap <buffer><silent> ih :<C-u>call <sid>header_textobj(v:true)<CR>
xnoremap <buffer><silent> ah :<C-u>call <sid>header_textobj(v:false)<CR>


" ==============================================
" START OF THE PLUGINS
" {configurazione_lista_plugins}
" ==============================================
" uso Vundle come gestore dei plugin.
" Per installarlo basta eseguire:
"
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
"
" in realtà potrei farlo con tutti i pacchetti, ma Vundle automatizza gli
" aggiornamenti dei vari pacchetti. Supporta pacchetti da qualsiasi repository
" git, ma se non specifico nulla assume che sia da github.
" Per aggiornare i pacchetti basta dare i comandi:
"   :PluginInstall
" oppure lanciare da terminale `nvim +PluginInstall +qall`
" per aggiornare ho `PluginUpdate`
" per rimuovere i non usati ho `PluginClean`
"
filetype off                   " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()            " required
Plugin 'VundleVim/Vundle.vim'  " required

" -------------------
" my plugins here
" -------------------

Plugin 'itchyny/lightline.vim' " aspetto migliorato della linea informativa
Plugin 'itchyny/vim-gitbranch'
Plugin 'jpalardy/vim-slime' " mandare linee di codice ad una REPL esterna
Plugin 'hanschen/vim-ipython-cell' " configurazione slime per python
Plugin 'vimwiki/vimwiki' " gestione di una wiki personale
Plugin 'unblevable/quick-scope' " highlight best letter for fast movement
Plugin 'junegunn/fzf.vim' " fuzzy search per vari scopi
" Plugin 'vim-syntastic/syntastic' " parser e linters
Plugin 'raivivek/vim-snakemake' " syntax highlight for snakemake files
Plugin 'mbbill/undotree' " history management
Plugin 'hrj/vim-DrawIt' " plugin per fare ascii art dentro Vim
Plugin 'mhinz/vim-startify' " plugin per fare uno schermo di inizio carino
Plugin 'tpope/vim-surround' " support per circondare testo
" -------------------
" end of plugins
" -------------------
call vundle#end()               " required
filetype plugin indent on       " required
set rtp+=~/.fzf
let g:loaded_python_provider = 0

set rtp+=/usr/share/powerline/bindings/vim

"------------------------------------------------------------------------------
" LIGHTLINE CONFIGURATION
" {configurazione_plugin_lightline}
"------------------------------------------------------------------------------
" configuro la barra di vim in maniera da aver sott'occhio anche il branch
" di git in cui sto lavorando, visto che sto usando le branches
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name'
      \ },
      \ }

"------------------------------------------------------------------------------
" SLIME CONFIGURATION
" {configurazione_plugin_slime}
"------------------------------------------------------------------------------
"
" se voglo usare il terminale di neovim devo specificarli il job-id
" per ottenerlo posso chiamare:
"
"     echo &channel
"
" se per caso sbaglio a configurare posso resettare la configurazione
" chiamando la seguente funzione:
"
"     SlimeConfig
"
" di default consigliano tmux, ma visto come funziona bene il terminale di
" neovim credo che l'opzione migliore sia farlo girare sempre dentro neovim
let g:slime_target = 'neovim'
" alternative possibili:
" * "tmux" - si collega ad uno specifico panel di tmux
" * "x11" - permette di cliccare su di una finestra ed averla come target
" * "neovim" - neovim terminal emulator

" fix paste issues in ipython
let g:slime_python_ipython = 1
"
"------------------------------------------------------------------------------
" IPYTHON-CELL CONFIGURATION
" {configurazione_plugin_ipython_cell}
"------------------------------------------------------------------------------
" Keyboard mappings. <Leader> is \ (backslash) by default

" a seguire ci sono i mapping di default di slime+ipython-cell
" tendo a non usarli come li impostano loro, quindi li rimuovo!
" " map <Leader>s to start IPython
" nnoremap <Leader>ss :SlimeSend1 ipython --matplotlib<CR>
" " map <Leader>r to run script
" nnoremap <Leader>sr :IPythonCellRun<CR>
" " map <Leader>R to run script and time the execution
" nnoremap <Leader>sR :IPythonCellRunTime<CR>
" " map <Leader>c to execute the current cell
" nnoremap <Leader>sC :IPythonCellExecuteCell<CR>
" " map <Leader>C to execute the current cell and jump to the next cell
" nnoremap <Leader>sc :IPythonCellExecuteCellJump<CR>
" " map <Leader>l to clear IPython screen
" nnoremap <Leader>sl :IPythonCellClear<CR>
" " map <Leader>x to close all Matplotlib figure windows
" nnoremap <Leader>sx :IPythonCellClose<CR>
" " map <Leader>h to send the current line or current selection to IPython
" nmap <Leader>sh <Plug>SlimeLineSend
" xmap <Leader>sh <Plug>SlimeRegionSend
" " map <Leader>p to run the previous command
" nnoremap <Leader>sp :IPythonCellPrevCommand<CR>
" " map <Leader>Q to restart ipython
" nnoremap <Leader>sQ :IPythonCellRestart<CR>
" " map <Leader>d to start debug mode
" nnoremap <Leader>sd :SlimeSend1 %debug<CR>
" " map <Leader>q to exit debug mode or IPython
" nnoremap <Leader>sq :SlimeSend1 exit<CR>

" map [# and ]# to jump to the previous and next cell header
au FileType python nnoremap [# :IPythonCellPrevCell<CR>
au FileType python nnoremap ]# :IPythonCellNextCell<CR>

" F9 mi permette di inviare una linea o una selezione
au FileType python imap <F9> <Esc><Plug>SlimeLineSend<Esc>jA
au FileType python nmap <F9> <Plug>SlimeLineSend<Esc>j
au FileType python vmap <F9> <Esc><Plug>SlimeRegionSend<Esc>gv

" F21 corrisponde a Shift-F9
au FileType python nnoremap <F21> :IPythonCellExecuteCellJump<CR>zz

" let g:pymode_rope = 0
" let g:pymode_folding=0
" let g:jedi#show_call_signatures = "1"
" let g:jedi#popup_on_dot = 0

"------------------------------------------------------------------------------
" VIMWIKI CONFIGURATION
" {configurazione_plugin_vimwiki}
"------------------------------------------------------------------------------

" questo dovrebbe disattivare il support di wimwiki ai markdown
" che è più un impiccio che altro...
let g:vimwiki_global_ext = 0

" vimwiki list di wiki, accedo con <leader>ws
" sono configurati in modo da esportare automaticamente
" dopo il salvataggio ed usare di default la sintassi markdown
let wiki_1 = {}
let wiki_1.path = '~/vimwiki/appunti_wiki/'
let wiki_1.path_html = '~/vimwiki/appunti_wiki_html/'
let wiki_1.auto_export = 1
" let wiki_1.syntax = 'markdown'

let wiki_2 = {}
let wiki_2.path = '~/vimwiki/private_wiki/'
let wiki_2.path_html = '~/vimwiki/private_wiki_html/'
let wiki_2.auto_export = 1
" let wiki_2.syntax = 'markdown'

let wiki_3 = {}
let wiki_3.path = '~/vimwiki/aegis_wiki/'
let wiki_3.path_html = '~/vimwiki/aegis_wiki_html/'
let wiki_3.auto_export = 1
" let wiki_3.syntax = 'markdown'

let g:vimwiki_list = [wiki_1, wiki_2, wiki_3]

"------------------------------------------------------------------------------
" CONFIGURAZIONE PLUGIN QUICKSCOPE
" {configurazione_plugin_quickscope}
"------------------------------------------------------------------------------
" change the highlight colors for quickscope
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline

"------------------------------------------------------------------------------
" CONFIGURAZIONE SYNTASTIC
" {configurazione_plugin_syntastic}
"------------------------------------------------------------------------------
" settaggi di syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 0
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0

"------------------------------------------------------------------------------
" HISTORY TREE PLUGIN SHORTCUTS
" {configurazione_plugin_undotree}
"------------------------------------------------------------------------------
nnoremap <F5> :UndotreeToggle<CR>

" let the diff windows breath a little bit more
let g:undotree_WindowLayout = 4

"------------------------------------------------------------------------------
" CONFIGURAZIONE DEL LEADER PER USARE FZF
" {configurazione_plugin_fzf}
"------------------------------------------------------------------------------
" tutti i comandi sono <lead>f
nnoremap <Leader>ff :Files<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader>fr :Rg<CR>
nnoremap <Leader>fm :Marks<CR>
nnoremap <Leader>fc :Maps<CR>
nnoremap <Leader>f: :History:<CR>
nnoremap <Leader>f/ :History/<CR>
nnoremap <Leader>fo :Locate
nnoremap <Leader>fl :Lines<CR>
nnoremap <Leader>ft :Tags<CR>

"------------------------------------------------------------------------------
" CONSIDERAZIONI GENERALI SU VIM
" {considerazioni_generali}
"------------------------------------------------------------------------------

" di seguito ci sono alcune note generali su neovim
" che mi piacerebbe tenere a mente.

" ### ricerca di regex dentro una selezione visiva
" c'è un token apposito \%V che rappresenta l'area
" selezionata. va messo due volte, una prima ed una dopo se si vuole il
" limite esatto della selezione visiva.
" se lo metto solo all'inizio la selezione arriva alla fine della riga
" se lo metto solo alla fine la selezione arriva all'inizio della riga
" ad esempio il seguente comando:
"
"     '<,'>s/\%V\(.*\)\%V/"\0"
"
" mette fra virgolette il testo selezionato visivamente
" un altro uso interessante delle stringhe di sostituzione è quello di
" modificarne il comportamento aggiungendo caratteri extra alla fine.
" :s/[re]/[sub]/g - applica il comando a tutte le occorrenze (altrimenti è
" soltanto uno per riga)
" :s/[re]//n - conta le occorrenze della stringa di ricerca, ma non
" compie sostituzioni
" inoltre si ho già fatto una ricerca i comandi successivi la usano
" automaticamente se non si specifica un altro pattern
" :/[pattern]
" :%s//[sub]/g - sostituisce pattern ovunque
" :%~n - effettua il conteggio su tutto il documento

" ### operazione nativa di sorting delle righe
" sempre in questo spirito, se ho una zona selezionata posso lanciare `sort`
" senza bisogno del comando esterno associato
" :'<,'>sort - mette in ordine (case sensitive)
" :'<,'>sort! - ordinamento inverso
" :'<,'>sort i - ignora il case
" :'<,'>sort u - lascia le righe uniche
" può essere utile per situazioni semplici

" ### fare mapping che possono essere ripetuti con un numero
" di default i mapping non possono essere ripetuti con un numero e possono
" anche interagire in malo modo con l'operatore `.`.
" Per ovviare posso fare un wrap usando la Command mode e `normal`
" map <key> :normal <newkeys><CR>
" dovrei rivedere tutti i mapping che ha senso ripetere per usare questo
" pattern

" -----------------------------------------------------------------------------
" CONFIGURAZIONE DI TASTI FISICI
" {configurazione_tasti_fisici}
" -----------------------------------------------------------------------------

" per lavorare con Vim c'è un remapping molto comune, che è quello di
" rimpiazzare completamente il taste Caps-Lock. le due sostituzioni più comuni
" sono con Esc e Ctrl. Dopo un po' di esperimenti ho deciso di andare con la
" sostituzione con Ctrl.
" Questo scambio è vantaggioso perché moltissime shortcut usare Ctrl ed averlo
" lì permette di usarlo ci continuo. Il segnale di uscita dalle modalità
" Insert e Visuale si può fare con <C-c>, mentre dal terminale si esce con
" <C-\><C-n>. In questo config configuro Esc per simularlo, ma in ogni caso
" risulta molto, molto più usato il tasto Ctrl, quindi come configurazione
" ripaga molto di più.
" Visto che su linux il tasto Caps-Lock è comodo per mettere le lettere
" accentate maiuscole, ho anche impostato per riattivarlo prendendo entrambi i
" tasti Shift. In ogni caso le lettere accentate si possono inserire premendo:
" <C-k><accento><lettera>

" -----------------------------------------------------------------------------
" NOTE SULLA CONFIGURAZIONE DEL TERMINALE CON NEOVIM
" {configurazione_bash_terminale}
" -----------------------------------------------------------------------------

" ### far funzionare il terminale di neovim quando apro un altra istanza
" usando questa configurazione (che non va qui dentro ma dentro la
" configurazione di bash) posso usare meglio il simulatore di terminale di
" neovim. Se non applico questa configurazione infatti se il terminale cerca
" di aprire una instanza di neovim finisco ad avere finestre innestate ed è un
" casino. Per evitarlo posso fare in modo che dentro il terminale emulato nvim
" ed affini sia un alias al server remoto che mi fa usare la istanza madre per
" editare. Questo mi permette di usare programmi come `vipe` e `vidir` senza
" problemi.

" per prima cosa devo usare il pacchetto neovim-remote:
"
"     pip install pynvim
"     pip install neovim-remote
"
" che mi fornisce il programma `nvr`, che mi permette di attaccarmi
" all'istanza di base quando viene richiesto un editor.
"
" Per farlo funzionare devo creare uno script `nvr_shield` che mi evita
" problemi di escaping (altrimenti le virgolette che servono al comando
" vengono interpretato come richiesta di salto ad un mark ed il programma
" impazzisce)
"
"     nvr -cc split --remote-wait +'set bufhidden=wipe' $@
"
" il comando -cc split apre in un nuovo split rispetto al terminale da cui
" apro, ed è disegnato in modo che il buffer che viene aperto si autodistrugga
" quando cambio focus.
" Se tolgo lo split neovim fa a coprire il terminale, poi dopo che salvo posso
" tornare indietro ed il buffer viene direttamente eliminato.
" sarebbe bello poter impostare soltanto programmi come vipe e vidir con
" questo comportamento temporaneo, e fare in modo che altre chiamate dal
" terminale aprano il buffer in modo permanente, ma non so come fare a
" distinguere i due...
"
" poi nel bashrc deve fare un layering di aliases che rimpiazza neovim
" con nvr quando li lancio dentro il terminale di neovim. qui non ho fatto
" l'alias anche sopra vim e basta perché ogni tanto mi fa comodo per testare
" delle cose...
"
"     export VISUAL='nvim5alpha'
"     if [ -n "$NVIM_LISTEN_ADDRESS" ]; then
"         export VISUAL="nvr_shield"
"     fi
"     alias nvim=$VISUAL
"     export EDITOR=$VISUAL
"     alias vi=$VISUAL
"
" ricordo che mentre si sta scrivendo sul terminale in ogni momento si può
" lanciare <c-x><c-e> per lanciare l'editor di default con la linea aperta.
" in questo modo si possono editare in modo facile linee lunghe.
" alla fine basta salvare ed uscire

" -----------------------------------------------------------------------------
" DTACH COME ALTERNATIVA A TMUX
" {usare_dtach_invece_di_tmux}
" -----------------------------------------------------------------------------

" tmux è un gran programma, ma le versioni moderne di neovim possono fare
" praticamente tutta la parte di window multiplexing anche meglio di quanto
" possa fare tmux.
" L'unica cosa che non posso sostituire con neovim è il detach delle sessioni.
" per fare questo posso usare un programma esterno che fa SOLTANTO quello,
" chiamato dtach.
" lo posso installare con:
"
"     sudo apt install dtach
"
" per usarlo lo posso chiamare in questo modo, creando una sessione staccata
" che posso riesumare in qualsiasi momento.
"
"     dtach -A /tmp/nvim -r winch nvim5alpha
"
" -A {nome del socket}
"       si collega o crea una nuova sessione.
"       non ho bisogno di creare il file, lo fa già lui.
"       se utilizzo `-a` si collega ma non la crea da zero
" -r winch
"       specifico che quando resumo la sessione devo mandare un segnale per
"       rinfrescare la finestra grafica
" nvim5alpha
"       dtach non sembra usare una sessione di bash che carichi bashrc,
"       quindi non vede i vari alias. Se avvio un terminale dentro neovim
"       comunque carica bashrc e tutto funziona a dovere.
"
" per poter fare il detach posso premere Ctrl-\
" quindi credo sia importante non interferire con quel comando per evitare
" problemi.

" -----------------------------------------------------------------------------
" IL COMANDO GN PER SEARCH AND REPLACE
" {discussione_comando_gn}
" -----------------------------------------------------------------------------

" il comando gn è utile nella ricerca ed edit dei match di una ricerca.
" Invece di usare 'n' per poi fare qualcosa, `gn` salta al prossimo match
" già in modalità visuale con la regione selezionata. in questo modo posso
" fare degli edit mirati.
"
" Ancora meglio è il fatto che, come `n`, è un motion, ma non implica
" "compi questa azione fino a là" quanto "compi questa azione direttamente là"
" questo significa che `dgn` è cancella la prossima occorrezza e `cgn` è
" cambia la prossima occorrenza, `gUgn` è trasforma la prossima occorrenza
" in maiuscolo. Questo rende l'intero comando ripetibile come un comando `.`
"
" -----------------------------------------------------------------------------
" GESTIONE DELLA DIRECTORY DI LAVORO
" {discussione_working_directory}
" -----------------------------------------------------------------------------
"
" vim ha una sua directory di lavoro generale, e ne può avere una specifica
" per ciascun buffer.
" per vedere in quale directory stia lavorando, basta usare
"   :pwd
" per cambiare la directory di lavoro di tutto vim a quello del file corrente:
"   :cd %:p:h
" posso cambiare la working directory a livello di intero tab con
"   :tcd %:p:h
" se invece voglio cambiare la directory di lavoro per una sola finestra ho
"   :lcd %:p:h
" ovviamente posso usare `cd`, `tcd` e `lcd` anche con directory arbitrarie
" ci sono opzioni per automatizzare questo processo, ma non so ancora se mi
" piacciano o meno...
" È importante notare che `lcd` è riferito alla window, non al buffer.
" Se lo imposto per un certo split, e apro un buffer in una posizione diversa,
" la directory di lavoro rimane sempre la stessa! allo stesso modo, se apro
" quel buffer in una finestra diversa, continuo a lavorare nella cwd della
" finestra.
" A livello di comportamente funzionano in modo gerarchico: se è presente la
" lcd usa quello, altrimenti la tcd altrimenti la cd normale.
"
"   set autochdir
"
" aggiusta automaticamente la directory complessiva di lavoro a quella del
" file (che non è male, specie per l'autocompletamento negli script).
"
"   autocmd BufEnter * silent! lcd %:p:h
"
" questo mi imposta la directory di lavoro per ciascun buffer nel momento in
" cui lo apro, e la imposta per soltanto quel buffer.
" potrei mappare un comando per il cambio esplicito della directory
"
"   nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>
"
" Addendum:
"  se faccio partire vi senza argomenti, mi setta come directory di lavoro
"  quella in cui mi trovo, ma se gli specifico un file parte dalla mia home...
"  non ho idea di quale strana interazione stia avvenendo...
"  sembra avere qualcosa a che fare con configurazioni e plugin, perché se
"  faccio partire con `nvim --clean`, che rimuove tutte le configurazioni,
"  parte correttamente nella directory di lavoro...


" -----------------------------------------------------------------------------
" COSE DA AGGIUSTARE
" -----------------------------------------------------------------------------
"
" * trovare un modo per liberarsi di vimwiki
" * fare un piccolo plugin per seguire link a file in modo simile al markdown,
"   con anche una indicazione di una sezione


