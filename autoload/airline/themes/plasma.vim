fun! <sid>loadconfig()
    try
        let s:config = IniParser#Read(glob('~/.config/kdeglobals'))
        let s:theme_config = IniParser#Read(glob('~/.config/kdedefaults/kdeglobals'))
    catch /.*/
    endtry
endfun

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

call <sid>loadconfig()

if !exists("g:plasma_dark")
    try
        if s:theme_config['General']['Name'] =~? 'dark'
            let g:plasma_dark = 1
        else
            let g:plasma_dark = 0
        endif
    catch /.*/
        let g:plasma_dark = 1
    endtry
endif

if !exists("g:plasma_high_contrast")
    let g:plasma_high_contrast = 0
endif

let s:plasmaNone  = 'NONE'
let s:plasmaBlack = '#000000'
let s:plasmaWhite = '#FFFFFF'

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

let s:plasmaWindowAB = <sid>getcolor('WM', 'activeBackground', '#475057')
let s:plasmaWindowAF = <sid>getcolor('WM', 'activeForeground', '#475057')
let s:plasmaWindowIB = <sid>getcolor('WM', 'inactiveBackground', '#475057')
let s:plasmaWindowIBlend = <sid>getcolor('WM', 'inactiveBlend', '#475057')
let s:plasmaWindowIF = <sid>getcolor('WM', 'inactiveForeground', '#475057')


if !exists("g:plasma_terminal_alt")
    let g:plasma_terminal    = '#00d3b8'
    let g:plasma_terminal_alt = !g:plasma_dark ? '#4bdfcc' : '#089c8a'
endif
if !exists("g:plasma_command_alt")
    let g:plasma_command     = '#e93a9a'
    let g:plasma_command_alt  = !g:plasma_dark ? '#ee74b7' : '#ab3175'
endif

let g:airline#themes#plasma#palette = {}

let s:Warning = [ s:plasmaBlack, s:plasmaNeutralBack, 232 , 214 ]
let s:Error   = [ s:plasmaBack, s:plasmaNegativeBack, 232 , 214 ]

" {{{ Normal
let s:airline_a_normal   = [ s:plasmaBack , s:plasmaAccent , 17  , 190 ]
let s:airline_b_normal   = [ s:plasmaAccent , s:plasmaPopupBack , 255 , 238 ]
let s:airline_c_normal   = [ s:plasmaInactive , s:plasmaBack , 85  , 234 ]
let g:airline#themes#plasma#palette.normal = airline#themes#generate_color_map(s:airline_a_normal, s:airline_b_normal, s:airline_c_normal)
let g:airline#themes#plasma#palette.normal_modified = {
      \ 'airline_c': [ s:plasmaAccent , s:plasmaBack , 255     , 53      , ''     ] ,
      \ }

let g:airline#themes#plasma#palette.normal.airline_warning = s:Warning
let g:airline#themes#plasma#palette.normal_modified.airline_warning = s:Warning
let g:airline#themes#plasma#palette.normal.airline_error = s:Error
let g:airline#themes#plasma#palette.normal_modified.airline_error = s:Error


let s:airline_a_insert = [ s:plasmaBack , s:plasmaPositiveFront , 17  , 45  ]
let s:airline_b_insert = [ s:plasmaFront , s:plasmaPositiveBack , 255 , 27  ]
let s:airline_c_insert = [ s:plasmaInactive , s:plasmaBack , 15  , 17  ]
let g:airline#themes#plasma#palette.insert = airline#themes#generate_color_map(s:airline_a_insert, s:airline_b_insert, s:airline_c_insert)
let g:airline#themes#plasma#palette.insert_modified = {
      \ 'airline_c': [ s:plasmaPositiveFront , s:plasmaBack , 255     , 53      , ''     ] ,
      \ }
let g:airline#themes#plasma#palette.insert_paste = {
      \ 'airline_a': [ s:airline_a_insert[0]   , s:plasmaNeutralFront , s:airline_a_insert[2] , 172     , ''     ] ,
      \ }

let g:airline#themes#plasma#palette.insert.airline_warning = s:Warning
let g:airline#themes#plasma#palette.insert_modified.airline_warning = s:Warning
let g:airline#themes#plasma#palette.insert.airline_error = s:Error
let g:airline#themes#plasma#palette.insert_modified.airline_error = s:Error


let s:airline_a_terminal = [ s:plasmaBack , g:plasma_terminal , 17  , 45  ]
let s:airline_b_terminal = [ s:plasmaFront , g:plasma_terminal_alt , 255 , 27  ]
let s:airline_c_terminal = [ s:plasmaInactive , s:plasmaBack , 15  , 17  ]
let g:airline#themes#plasma#palette.terminal = airline#themes#generate_color_map(s:airline_a_terminal, s:airline_b_terminal, s:airline_c_terminal)


let s:airline_a_replace = [ s:plasmaBack , s:plasmaNegativeFront , 124 , ''  ]
let s:airline_b_replace = [ s:plasmaFront , s:plasmaNegativeBack , 255 , 27  ]
let s:airline_c_replace = [ s:plasmaInactive , s:plasmaBack , 15  , 17  ]

let g:airline#themes#plasma#palette.replace = airline#themes#generate_color_map(s:airline_a_replace, s:airline_b_replace, s:airline_c_replace)
let g:airline#themes#plasma#palette.replace_modified ={
      \ 'airline_c': [ s:plasmaNegativeFront , s:plasmaBack , 255     , 53      , ''     ] ,
      \ }
let g:airline#themes#plasma#palette.replace.airline_warning = s:Warning
let g:airline#themes#plasma#palette.replace_modified.airline_warning = s:Warning
let g:airline#themes#plasma#palette.replace.airline_error = s:Error
let g:airline#themes#plasma#palette.replace_modified.airline_error = s:Error

let s:airline_a_visual = [ s:plasmaBack , s:plasmaNeutralFront , 232 , 214 ]
let s:airline_b_visual = [ s:plasmaFront , s:plasmaNeutralBack , 232 , 202 ]
let s:airline_c_visual = [ s:plasmaInactive , s:plasmaBack , 15  , 52  ]
let g:airline#themes#plasma#palette.visual = airline#themes#generate_color_map(s:airline_a_visual, s:airline_b_visual, s:airline_c_visual)
let g:airline#themes#plasma#palette.visual_modified = {
      \ 'airline_c': [ s:plasmaNeutralFront , s:plasmaBack , 255     , 53      , ''     ] ,
      \ }
let g:airline#themes#plasma#palette.visual.airline_warning = s:Warning
let g:airline#themes#plasma#palette.visual_modified.airline_warning = s:Warning
let g:airline#themes#plasma#palette.visual.airline_error = s:Error
let g:airline#themes#plasma#palette.visual_modified.airline_error = s:Error

let s:airline_a_inactive = [ s:plasmaWindowIF , s:plasmaWindowIB , 239 , 234 , '' ]
let s:airline_b_inactive = [ s:plasmaWindowIF , s:plasmaWindowIB , 239 , 235 , '' ]
let s:airline_c_inactive = [ s:plasmaWindowIF , s:plasmaWindowIB , 239 , 236 , '' ]
let g:airline#themes#plasma#palette.inactive = airline#themes#generate_color_map(s:airline_a_inactive, s:airline_b_inactive, s:airline_c_inactive)
let g:airline#themes#plasma#palette.inactive_modified = {
      \ 'airline_c': [ s:plasmaSelection , s:plasmaWindowIB , 97 , '' , '' ] ,
      \ }

let s:airline_a_commandline = [ s:plasmaBack , g:plasma_command , 17  , 40 ]
let s:airline_b_commandline = [ s:plasmaFront , g:plasma_command_alt , 255 , 238 ]
let s:airline_c_commandline = [ s:plasmaInactive , s:plasmaBack , 85  , 234 ]
let g:airline#themes#plasma#palette.commandline = airline#themes#generate_color_map(s:airline_a_commandline, s:airline_b_commandline, s:airline_c_commandline)
let g:airline#themes#plasma#palette.commandline_modified = {
      \ 'airline_c': [ g:plasma_command , s:plasmaBack , 97 , '' , '' ] ,
      \ }
let g:airline#themes#plasma#palette.commandline.airline_warning = s:Warning
let g:airline#themes#plasma#palette.commandline_modified.airline_warning = s:Warning
let g:airline#themes#plasma#palette.commandline.airline_error = s:Error
let g:airline#themes#plasma#palette.commandline_modified.airline_error = s:Error

let g:airline#themes#plasma#palette.accents = {
      \ 'red': [ s:plasmaNegativeFront , '' , 160 , ''  ]
      \ }

