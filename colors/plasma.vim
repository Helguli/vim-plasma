" vim:fdm=marker

" {{{1 FUNCTIONS
" {{{2 Highlighting function
fun! <sid>hi(group, fg, bg, attr, sp)
    if !empty(a:fg)
        exec "hi ".a:group." guifg=".a:fg
    endif
    if !empty(a:bg)
        exec "hi ".a:group." guibg=".a:bg
    endif
    if !empty(a:attr)
        exec "hi ".a:group." gui=".a:attr
    endif
    if !empty(a:sp)
        exec "hi ".a:group." guisp=".a:sp
    endif
endfun

" {{{2 Ini file read function
fun! <sid>loadconfig()
    try
        let s:config = IniParser#Read(glob('~/.config/kdeglobals'))
        let s:theme_config = IniParser#Read(glob('~/.config/kdedefaults/kdeglobals'))
    catch /.*/
    endtry
endfun

" {{{2 Get color from config file
fun! <sid>getcolor(section, key, default)
    try
        if has_key(s:config, a:section)
            let l:c = s:config[a:section][a:key]
            return substitute(substitute(l:c,'\d\+','\=printf("#%02x", submatch(0))', 'g'), ',#', '', 'g')
        endif
    catch /.*/
        return a:default
    endtry
endfun

" {{{1 GENERAL SETTINGS
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="plasma"

call <sid>loadconfig()

if !exists("g:plasma_dark")
    try
        if s:theme_config['General']['ColorScheme'] =~? 'dark'
            let g:plasma_dark = 1
        else
            let g:plasma_dark = 0
        endif
    catch /.*/
        let g:plasma_dark = 1
    endtry
endif
if g:plasma_dark
    set background=dark
else
    set background=light
endif

if !exists("g:plasma_high_contrast")
    let g:plasma_high_contrast = 0
endif

" {{{1 COLOR DEFINITIONS
" {{{2 Constant Colors

let s:plasmaBlack        = '#000000'
let s:plasmaWhite        = '#FFFFFF'
let s:plasmaGray         = '#686b6f'
let s:plasmaGrayAlt      = g:plasma_dark ? '#a1a9b1' : '#505357'
let s:plasmaBlue         = '#1d99f3'
let s:plasmaBlueAlt      = g:plasma_dark ? '#3daee9' : '#3282ac'
let s:plasmaDarkBlue     = '#0064f3'
let s:plasmaDarkBlueAlt  = g:plasma_dark ? '#4b91e9' : '#084fac'
let s:plasmaPink         = '#e93a9a'
let s:plasmaPinkAlt      = g:plasma_dark ? '#ee74b7' : '#ab3175'
let s:plasmaRed          = '#e93d58'
let s:plasmaRedAlt       = g:plasma_dark ? '#ee7689' : '#ab3347'
let s:plasmaOrange       = '#e9643a'
let s:plasmaOrangeAlt    = g:plasma_dark ? '#ee9174' : '#ab4f32'
let s:plasmaYellow       = '#e8cb2d'
let s:plasmaYellowAlt    = g:plasma_dark ? '#edd96b' : '#aa9729'
let s:plasmaGreen        = '#3dd425'
let s:plasmaGreenAlt     = g:plasma_dark ? '#76df65' : '#329d23'
let s:plasmaBlueGreen    = '#27be73'
let s:plasmaBlueGreenAlt = g:plasma_dark ? '#56dc99' : '#1b834f'
let s:plasmaCyan         = '#00d3b8'
let s:plasmaCyanAlt      = g:plasma_dark ? '#4bdfcc' : '#089c8a'
let s:plasmaLavender     = '#b875dc'
let s:plasmaLavenderAlt  = g:plasma_dark ? '#cc9de5' : '#885aa3'
let s:plasmaPurple       = '#926ee4'
let s:plasmaPurpleAlt    = g:plasma_dark ? '#b198eb' : '#6e56a9'

" {{{2 Colors from config

let s:plasmaNone    = 'NONE'
let s:plasmaFront   = <sid>getcolor('Colors:View', 'ForegroundNormal',    '#fcfcfc')
let s:plasmaBack    = <sid>getcolor('Colors:View', 'BackgroundNormal',    '#1b1e20')
let s:plasmaBackAlt = <sid>getcolor('Colors:View', 'BackgroundAlternate', '#232629')
let s:plasmaAccent  = <sid>getcolor('General',     'AccentColor',         '#3daee9')

let s:plasmaFront = g:plasma_high_contrast ? (!g:plasma_dark ? s:plasmaBlack : s:plasmaWhite) : s:plasmaFront
let s:plasmaBack = g:plasma_high_contrast ? (g:plasma_dark ? s:plasmaBlack : s:plasmaWhite) : s:plasmaBack

let s:plasmaCursorFront = <sid>getcolor('Colors:View', 'ForegroundNormal', '#fcfcfc')
let s:plasmaCursorBack  = <sid>getcolor('General',     'AccentColor',      '#3daee9')
let s:plasmaCursorLine  = <sid>getcolor('General',     'AccentColor',      '#3daee9')

let s:plasmaSelection = <sid>getcolor('Colors:Selection', 'BackgroundNormal', '#1e5774')

let s:plasmaInactive  = <sid>getcolor('Colors:View', 'ForegroundInactive', '#a1a9b1')

let s:plasmaPopupFront          = <sid>getcolor('Colors:Tooltip', 'ForegroundNormal',    '#fcfcfc')
let s:plasmaPopupBack           = <sid>getcolor('Colors:Tooltip', 'BackgroundNormal',    '#31363b')
let s:plasmaPopupHighlightFront = <sid>getcolor('Colors:Tooltip', 'ForegroundActive',    '#3daee9')
let s:plasmaPopupHighlightBack  = <sid>getcolor('Colors:Tooltip', 'BackgroundAlternate', '#2a2e32')

let s:plasmaNegativeFront = <sid>getcolor('Colors:View', 'ForegroundNegative', '#da4453')
let s:plasmaNeutralFront  = <sid>getcolor('Colors:View', 'ForegroundNeutral',  '#f67400')
let s:plasmaPositiveFront = <sid>getcolor('Colors:View', 'ForegroundPositive', '#27ae60')
let s:plasmaNegativeBack  = <sid>getcolor('Colors:Selection', 'ForegroundNegative', '#b03745')
let s:plasmaNeutralBack   = <sid>getcolor('Colors:Selection', 'ForegroundNeutral',  '#c65c00')
let s:plasmaPositiveBack  = <sid>getcolor('Colors:Selection', 'ForegroundPositive', '#176839')

" {{{1 HIGHLIGHTING
" {{{2 Basic

call <sid>hi('Normal', s:plasmaFront, s:plasmaBack, 'none', {})


call <sid>hi('SpecialKey',     s:plasmaAccent,              {},                         'none',      {})
call <sid>hi('EndOfBuffer',    s:plasmaInactive,            {},                         'none',      {})
call <sid>hi('TermCursor',     s:plasmaCursorFront,         s:plasmaCursorBack,         'none',      {})
call <sid>hi('NonText',        s:plasmaInactive,            {},                         'none',      {})
call <sid>hi('Directory',      s:plasmaBlue,                {},                         'none',      {})
call <sid>hi('ErrorMsg',       s:plasmaFront,               s:plasmaNegativeBack,       'none',      {})
call <sid>hi('IncSearch',      s:plasmaBack,                s:plasmaYellow,             'none',      {})
call <sid>hi('Search',         s:plasmaBlack,               s:plasmaYellow,             'none',      {})
call <sid>hi('MoreMsg',        s:plasmaBlueGreenAlt,        {},                         'bold',      {})
call <sid>hi('ModeMsg',        {},                          {},                         'bold',      {})
call <sid>hi('LineNr',         s:plasmaInactive,            s:plasmaBackAlt,            'none',      {})
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
call <sid>hi('CursorLineNr',   s:plasmaAccent,              s:plasmaBackAlt,            'none',      {})
call <sid>hi('CursorLineSign', s:plasmaAccent,              s:plasmaBackAlt,            'none',      {})

" {{{2 Syntax
hi! link CursorLineFold FoldColumn
call <sid>hi('Question',       s:plasmaGreenAlt,            {},                         'bold',      {})
call <sid>hi('StatusLine',     {},                          {},                         'none',      {})
call <sid>hi('StatusLineNC',   {},                          {},                         'none',      {})
hi! link WinSeparator VertSplit
call <sid>hi('VertSplit',      s:plasmaBack,                s:plasmaFront,              'none',      {})
call <sid>hi('Title',          s:plasmaAccent,              s:plasmaNone,               'bold',      {})
call <sid>hi('Visual',         s:plasmaNone,                s:plasmaSelection,          'none',      {})
call <sid>hi('WarningMsg',     s:plasmaRed,                 {},                         'none',      {})
call <sid>hi('WildMenu',       {},                          {},                         'none',      {})
call <sid>hi('Folded',         s:plasmaInactive,            s:plasmaBackAlt,            'none',      {})
call <sid>hi('FoldColumn',     s:plasmaInactive,            s:plasmaBack,               'none',      {})
call <sid>hi('DiffAdd',        s:plasmaFront,               s:plasmaPositiveBack,       'none',      {})
call <sid>hi('DiffChange',     s:plasmaFront,               s:plasmaNeutralBack,        'none',      {})
call <sid>hi('DiffDelete',     s:plasmaFront,               s:plasmaNegativeBack,       'none',      {})
call <sid>hi('DiffText',       {},                          {},                         'none',      {})
call <sid>hi('SignColumn',     s:plasmaInactive,            s:plasmaBackAlt,            'none',      {})
call <sid>hi('Conceal',        s:plasmaFront,               {},                         'none',      {})
call <sid>hi('SpellBad',       {},                          {},                         'undercurl', s:plasmaRed)
call <sid>hi('SpellCap',       {},                          {},                         'undercurl', s:plasmaBlue)
call <sid>hi('SpellRare',      {},                          {},                         'undercurl', s:plasmaPink)
call <sid>hi('SpellLocal',     {},                          {},                         'undercurl', s:plasmaCyan)
call <sid>hi('Pmenu',          s:plasmaPopupFront,          s:plasmaPopupBack,          'none',      {})
call <sid>hi('PmenuSel',       s:plasmaPopupHighlightFront, s:plasmaPopupHighlightBack, 'none',      {})
call <sid>hi('PmenuSbar',      {},                          s:plasmaBackAlt,            'none',      {})
call <sid>hi('PmenuThumb',     s:plasmaAccent,              s:plasmaAccent,             'none',      {})
call <sid>hi('TabLine',        s:plasmaInactive,            s:plasmaBackAlt,            'none',      {})
call <sid>hi('TabLineSel',     {},                          s:plasmaBack,               'bold',      {})
call <sid>hi('TabLineFill',    {},                          {},                         'none',      {})
call <sid>hi('CursorColumn',   {},                          s:plasmaBackAlt,            'none',      {})
call <sid>hi('CursorLine',     {},                          s:plasmaBackAlt,            'none',      {})
call <sid>hi('ColorColumn',    {},                          s:plasmaBlack,              'none',      {})
hi! link QuickFixLine Search
hi! link Whitespace NonText
hi! link MsgSeparator StatusLine
hi! link NormalFloat Pmenu
hi! link FloatBorder WinSeparator
call <sid>hi('Cursor',         s:plasmaCursorFront,         s:plasmaCursorBack,         'none', {})
call <sid>hi('RedrawDebugNormal', s:plasmaBack, s:plasmaFront, 'none', {})
call <sid>hi('RedrawDebugClear', s:plasmaFront, s:plasmaNeutralFront, 'none', {})
call <sid>hi('RedrawDebugComposed', s:plasmaFront, s:plasmaPositiveFront, 'none', {})
call <sid>hi('RedrawDebugRecompose', s:plasmaFront, s:plasmaNegativeFront, 'none', {})
call <sid>hi('lCursor',        s:plasmaCursorFront,         s:plasmaCursorBack,         'none', {})
call <sid>hi('FloatShadow', {}, {}, 'none', {})
call <sid>hi('FloatShadowThrough', {}, {}, 'none', {})


call <sid>hi('Error',      {}, s:plasmaRed, 'none', {})
call <sid>hi('Todo',       s:plasmaDarkBlue, s:plasmaYellowAlt, 'bold', {})
hi! link String Constant
call <sid>hi('Constant',   s:plasmaGreen, {}, 'none', {})
hi! link Character Constant
call <sid>hi('Number', s:plasmaLavenderAlt, {}, 'none', {})
hi! link Boolean Constant
hi! link Float Number
call <sid>hi('Function', s:plasmaBlueGreenAlt, {}, 'bold', {})
call <sid>hi('Identifier', s:plasmaCyan, {}, 'none', {})
hi! link Conditional Statement
call <sid>hi('Statement',  s:plasmaYellow, {}, 'bold', {})
hi! link Repeat Statement
hi! link Label Statement
hi! link Operator Statement
hi! link Keyword Statement
hi! link Exception Statement
hi! link Include PreProc
call <sid>hi('PreProc',    s:plasmaPurple, {}, 'none', {})
hi! link Define PreProc
hi! link Macro PreProc
hi! link PreCondit PreProc
hi! link StorageClass Type
call <sid>hi('Type',       s:plasmaGreenAlt, {}, 'bold', {})
hi! link Structure Type
hi! link Typedef Type
hi! link Tag Special
call <sid>hi('Special',    s:plasmaOrangeAlt, {}, 'none', {})
hi! link SpecialChar Special
hi! link Delimiter Special
hi! link SpecialComment Special
hi! link Debug Special
call <sid>hi('DiagnosticError', s:plasmaNegativeFront, s:plasmaNone, 'none', {})
call <sid>hi('DiagnosticWarn',  s:plasmaNeutralFront, s:plasmaNone, 'none', {})
call <sid>hi('DiagnosticInfo',  s:plasmaPositiveFront, s:plasmaNone, 'none', {})
call <sid>hi('DiagnosticHint',  s:plasmaInactive, s:plasmaNone, 'none', {})
call <sid>hi('DiagnosticUnderlineError', {}, {}, 'underline', s:plasmaNegativeFront)
call <sid>hi('DiagnosticUnderlineWarn',  {}, {}, 'underline', s:plasmaNeutralFront)
call <sid>hi('DiagnosticUnderlineInfo',  {}, {}, 'underline', s:plasmaPositiveFront)
call <sid>hi('DiagnosticUnderlineHint',  {}, {}, 'underline', s:plasmaInactive)
hi! link DiagnosticVirtualTextError DiagnosticError
hi! link DiagnosticVirtualTextWarn DiagnosticWarn
hi! link DiagnosticVirtualTextInfo DiagnosticInfo
hi! link DiagnosticVirtualTextHint DiagnosticHint
hi! link DiagnosticFloatingError DiagnosticError
hi! link DiagnosticFloatingWarn DiagnosticWarn
hi! link DiagnosticFloatingInfo DiagnosticInfo
hi! link DiagnosticFloatingHint DiagnosticHint
call <sid>hi('DiagnosticSignError', s:plasmaNegativeFront, s:plasmaBackAlt, 'none', {})
call <sid>hi('DiagnosticSignWarn', s:plasmaNeutralFront, s:plasmaBackAlt, 'none', {})
call <sid>hi('DiagnosticSignInfo', s:plasmaPositiveFront, s:plasmaBackAlt, 'none', {})
call <sid>hi('DiagnosticSignHint', s:plasmaInactive, s:plasmaBackAlt, 'none', {})
call <sid>hi('MatchParen', {}, s:plasmaAccent, 'none', {})
call <sid>hi('Comment', s:plasmaGray, {}, 'italic', {})
call <sid>hi('Underlined', s:plasmaInactive, {}, 'underline', {})
call <sid>hi('Ignore', s:plasmaInactive, {}, 'none', {})


call <sid>hi('CursorIM',       s:plasmaCursorFront,         s:plasmaCursorBack,         'none', {})
call <sid>hi('VisualNOS',      s:plasmaNone,                s:plasmaSelection,          'none', {})

hi! link diffAdded   DiffAdd
hi! link diffChanged DiffChange
hi! link diffRemoved DiffDelete

" {{{1 PLUGIN HIGHLIGHTING
" {{{2 IndentBlankLine
call <sid>hi('IndentBlanklineChar', s:plasmaInactive, {}, 'none', {})
call <sid>hi('IndentBlanklineSpaceChar', s:plasmaInactive, {}, 'none', {})
call <sid>hi('IndentBlanklineSpaceCharBlankline', s:plasmaInactive, {}, 'none', {})
call <sid>hi('IndentBlanklineContextChar', s:plasmaInactive, {}, 'none', {})
call <sid>hi('IndentBlanklineContextStart', {}, {}, 'underline', s:plasmaInactive)

" {{{2 Coc Neovim

call <sid>hi('CocCodeLens', s:plasmaInactive, {}, 'none', {})
call <sid>hi('CocUnderline', {}, {}, 'underline', {})
call <sid>hi('CocBold', {}, {}, 'bold', {})
call <sid>hi('CocItalic', {}, {}, 'italic', {})
call <sid>hi('CocStrikeThrough', {}, {}, 'strikethrough', {})
call <sid>hi('CocMarkdownLink', s:plasmaInactive, {}, 'none', {})
call <sid>hi('CocDisabled', s:plasmaInactive, {}, 'none', {})
call <sid>hi('CocSearch', s:plasmaPopupHighlightFront, {}, 'none', {})

hi! link CocFloating Pmenu
hi! link CocMenuSel PmenuSel
hi! link CocFloatThumb PmenuThumb
hi! link CocFloatSbar PmenuSbar

call <sid>hi('CocNotificationProgress', s:plasmaPopupHighlightFront, {}, 'none', {})
call <sid>hi('CocPumVirtualText', s:plasmaInactive, {}, 'none', {})
call <sid>hi('CocFloatDividingLine', s:plasmaInactive, {}, 'none', {})
call <sid>hi('CocCursorTransparent', {}, {}, 'strikethrough', {})
call <sid>hi('CocInlayHint', {}, {}, 'none', {})

"call <sid>hi('CocSymbolUnit', {}, {}, 'none', {})
"call <sid>hi('CocSymbolNumber', {}, {}, 'none', {})
"call <sid>hi('CocSymbolFunction', {}, {}, 'none', {})
"call <sid>hi('CocSymbolKey', {}, {}, 'none', {})
"call <sid>hi('CocSymbolKeyword', {}, {}, 'none', {})
"call <sid>hi('CocSymbolReference', {}, {}, 'none', {})
"call <sid>hi('CocSymbolFolder', {}, {}, 'none', {})
"call <sid>hi('CocSymbolVariable', {}, {}, 'none', {})
"call <sid>hi('CocSymbolNull', {}, {}, 'none', {})
"call <sid>hi('CocSymbolValue', {}, {}, 'none', {})
"call <sid>hi('CocSymbolConstant', {}, {}, 'none', {})
"call <sid>hi('CocSymbolText', {}, {}, 'none', {})
"call <sid>hi('CocSymbolModule', {}, {}, 'none', {})
"call <sid>hi('CocSymbolPackage', {}, {}, 'none', {})
"call <sid>hi('CocSymbolClass', {}, {}, 'none', {})
"call <sid>hi('CocSymbolOperator', {}, {}, 'none', {})
"call <sid>hi('CocSymbolStruct', {}, {}, 'none', {})
"call <sid>hi('CocSymbolObject', {}, {}, 'none', {})
"call <sid>hi('CocSymbolMethod', {}, {}, 'none', {})
"call <sid>hi('CocSymbolArray', {}, {}, 'none', {})
"call <sid>hi('CocSymbolEnum', {}, {}, 'none', {})
"call <sid>hi('CocSymbolField', {}, {}, 'none', {})
"call <sid>hi('CocSymbolInterface', {}, {}, 'none', {})
"call <sid>hi('CocSymbolProperty', {}, {}, 'none', {})
"call <sid>hi('CocSymbolColor', {}, {}, 'none', {})
"call <sid>hi('CocSymbolFile', {}, {}, 'none', {})
"call <sid>hi('CocSymbolEvent', {}, {}, 'none', {})
"call <sid>hi('CocSymbolTypeParameter', {}, {}, 'none', {})
"call <sid>hi('CocSymbolConstructor', {}, {}, 'none', {})
"call <sid>hi('CocSymbolSnippet', {}, {}, 'none', {})
"call <sid>hi('CocSymbolBoolean', {}, {}, 'none', {})
"call <sid>hi('CocSymbolNamespace', {}, {}, 'none', {})
"call <sid>hi('CocSymbolString', {}, {}, 'none', {})
"call <sid>hi('CocSymbolEnumMember', {}, {}, 'none', {})

" {{{2 GitGutter
call <sid>hi('GitGutterAdd',    s:plasmaPositiveFront, s:plasmaBackAlt, 'none', {})
call <sid>hi('GitGutterChange', s:plasmaNeutralFront,  s:plasmaBackAlt, 'none', {})
call <sid>hi('GitGutterDelete', s:plasmaNegativeFront, s:plasmaBackAlt, 'none', {})


call <sid>hi('GitGutterAddLine',    {}, s:plasmaPositiveBack, 'none', {})
call <sid>hi('GitGutterChangeLine', {}, s:plasmaNeutralBack, 'none', {})
call <sid>hi('GitGutterDeleteLine', {}, {}, 'underline', s:plasmaNegativeBack)

