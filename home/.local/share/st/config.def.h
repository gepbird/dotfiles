/* See LICENSE file for copyright and license details. */

/*
 * appearance
 *
 * font: see http://freedesktop.org/software/fontconfig/fontconfig-user.html
 */
static char* font = "Liberation Mono:pixelsize=16:antialias=true:autohint=true";
static int borderpx = 0;

/*
 * What program is execed by st depends of these precedence rules:
 * 1: program passed with -e
 * 2: scroll and/or utmp
 * 3: SHELL environment variable
 * 4: value of shell in /etc/passwd
 * 5: value of shell in config.h
 */
static char* shell = "/bin/zsh";
char* utmp = NULL;
/* scroll program: to enable use a string like "scroll" */
char* scroll = NULL;
char* stty_args = "stty raw pass8 nl -echo -iexten -cstopb 38400";

/* identification sequence returned in DA and DECID */
char* vtiden = "\033[?6c";

/* Kerning / character bounding-box multipliers */
static float cwscale = 1.0;
static float chscale = 1.0;

/*
 * word delimiter string
 *
 * More advanced example: L" `'\"()[]{}"
 */
wchar_t* worddelimiters = L" ";

/* selection timeouts (in milliseconds) */
static unsigned int doubleclicktimeout = 300;
static unsigned int tripleclicktimeout = 600;

/* alt screens */
int allowaltscreen = 1;

/* allow certain non-interactive (insecure) window operations such as:
   setting the clipboard text */
int allowwindowops = 0;

/*
 * draw latency range in ms - from new content/keypress/etc until drawing.
 * within this range, st draws when content stops arriving (idle). mostly it's
 * near minlatency, but it waits longer for slow updates to avoid partial draw.
 * low minlatency will tear/flicker more, as it can "detect" idle too early.
 */
static double minlatency = 8;
static double maxlatency = 33;

/*
 * blinking timeout (set to 0 to disable blinking) for the terminal blinking
 * attribute.
 */
static unsigned int blinktimeout = 800;

/*
 * thickness of underline and bar cursors
 */
static unsigned int cursorthickness = 2;

/*
 * 1: render most of the lines/blocks characters without using the font for
 *    perfect alignment between cells (U2500 - U259F except dashes/diagonals).
 *    Bold affects lines thickness if boxdraw_bold is not 0. Italic is ignored.
 * 0: disable (render all U25XX glyphs normally from the font).
 */
const int boxdraw = 1;
const int boxdraw_bold = 0;

/* braille (U28XX):  1: render as adjacent "pixels",  0: use font */
const int boxdraw_braille = 0;

/*
 * bell volume. It must be a value between -100 and 100. Use 0 for disabling
 * it
 */
static int bellvolume = 0;

/* default TERM value */
char* termname = "st-256color";

/*
 * spaces per tab
 *
 * When you are changing this value, don't forget to adapt the »it« value in
 * the st.info and appropriately install the st.info in the environment where
 * you use this st version.
 *
 *	it#$tabspaces,
 *
 * Secondly make sure your kernel is not expanding tabs. When running `stty
 * -a` »tab0« should appear. You can tell the terminal to not expand tabs by
 *  running following command:
 *
 *	stty tabs
 */
unsigned int tabspaces = 8;

/* Terminal colors (16 first used in escape sequence) */
static const char* colorname[] = {
  /* 8 normal colors */
  [0]  = "#282828", /* hard contrast: #1d2021 / soft contrast: #32302f */
  [1]  = "#cc241d", /* red     */
  [2]  = "#98971a", /* green   */
  [3]  = "#d79921", /* yellow  */
  [4]  = "#458588", /* blue    */
  [5]  = "#b16286", /* magenta */
  [6]  = "#689d6a", /* cyan    */
  [7]  = "#a89984", /* white   */

  /* 8 bright colors */
  [8]  = "#928374", /* black   */
  [9]  = "#fb4934", /* red     */
  [10] = "#b8bb26", /* green   */
  [11] = "#fabd2f", /* yellow  */
  [12] = "#83a598", /* blue    */
  [13] = "#d3869b", /* magenta */
  [14] = "#8ec07c", /* cyan    */
  [15] = "#ebdbb2", /* white   */
};


/*
 * Default colors (colorname index)
 * foreground, background, cursor, reverse cursor
 */
unsigned int defaultfg = 15;
unsigned int defaultbg = 0;
unsigned int defaultcs = 15;
static unsigned int defaultrcs = 257;
unsigned int const currentBg = 0, buffSize = 65536;
/// Enable double / triple click yanking / selection of word / line.
int const mouseYank = 1, mouseSelect = 0;
/// [Vim Browse] Colors for search results currently on screen.
unsigned int const highlightBg = 160, highlightFg = 15;
char const wDelS[] = "!\"#$%&'()*+,-./:;<=>?@[\\]^`{|}~", wDelL[] = " \t";
char* nmKeys[] = {              ///< Shortcusts executed in normal mode
  "R/Building\nN", "r/Building\n", "X/juli@machine\nN", "x/juli@machine\n",
  "Q?[Leaving vim, starting execution]\n","F/: error:\nN", "f/: error:\n", "DQf"
};
unsigned int const amountNmKeys = sizeof(nmKeys) / sizeof(*nmKeys);
/// Style of the {command, search} string shown in the right corner (y,v,V,/)
Glyph styleSearch = { ' ', ATTR_ITALIC | ATTR_BOLD_FAINT, 7, 16 };
Glyph style[] = { {' ',ATTR_ITALIC | ATTR_FAINT,15,16}, {' ',ATTR_ITALIC,232,11},
                 {' ', ATTR_ITALIC, 232, 4}, {' ', ATTR_ITALIC, 232, 12} };

/*
 * Default shape of cursor
 * 2: Block ("█")
 * 4: Underline ("_")
 * 6: Bar ("|")
 * 7: Snowman ("☃")
 */
static unsigned int cursorshape = 2;

/*
 * Default columns and rows numbers
 */

static unsigned int cols = 80;
static unsigned int rows = 24;

/*
 * Default colour and shape of the mouse cursor
 */
static unsigned int mouseshape = XC_xterm;
static unsigned int mousefg = 7;
static unsigned int mousebg = 0;

/*
 * Color used to display font attributes when fontconfig selected a font which
 * doesn't match the ones requested.
 */
static unsigned int defaultattr = 11;

#define Alt Mod1Mask
#define Sup Mod4Mask
#define Ctr ControlMask
#define Sft ShiftMask
#define Any XK_ANY_MOD
#define Nom XK_NO_MOD
#define Mo3 Mod3Mask

/*
 * Force mouse select/shortcuts while mask is active (when MODE_MOUSE is set).
 * Note that if you want to use ShiftMask with selmasks, set this to an other
 * modifier, set to 0 to not use it.
 */
static uint forcemousemod = Sft;

/*
 * Internal mouse shortcuts.
 * Beware that overloading Button1 will disable the selection.
 */
static MouseShortcut mshortcuts[] = {
  /* mask       button   function  argument       release */
  { Any,        Button2, selpaste, {.i = 0},      1 },
  { Sft,        Button4, ttysend,  {.s = "\033[5;2~"} },
  { Any,        Button4, ttysend,  {.s = "\031"} },
  { Sft,        Button5, ttysend,  {.s = "\033[6;2~"} },
  { Any,        Button5, ttysend,  {.s = "\005"} },
};

/* Internal keyboard shortcuts. */

static Shortcut shortcuts[] = {
  /* mask       keysym       function       argument */
  { Any,        XK_Break,    sendbreak,     {.i = 0} },
  { Ctr,        XK_Print,    toggleprinter, {.i = 0} },
  { Sft,        XK_Print,    printscreen,   {.i = 0} },
  { Any,        XK_Print,    printsel,      {.i = 0} },
  { Ctr|Sft,    XK_Z,        zoom,          {.f = +1} },
  { Ctr|Sft,    XK_U,        zoom,          {.f = -1} },
  { Ctr|Sft,    XK_Home,     zoomreset,     {.f = 0} },
  { Ctr|Sft,    XK_C,        clipcopy,      {.i = 0} },
  { Ctr|Sft,    XK_V,        clippaste,     {.i = 0} },
  { Ctr|Sft,    XK_Y,        selpaste,      {.i = 0} },
  { Sft,        XK_Insert,   selpaste,      {.i = 0} },
  { Ctr|Sft,    XK_Num_Lock, numlock,       {.i = 0} },
  { Sft,        XK_Escape,   normalMode,    {.i = 0} },
};

/*
 * Special keys (change & recompile st.info accordingly)
 *
 * Mask value:
 * * Use XK_ANY_MOD to match the key no matter modifiers state
 * * Use XK_NO_MOD to match the key alone (no modifiers)
 * appkey value:
 * * 0: no value
 * * > 0: keypad application mode enabled
 * *   = 2: term.numlock = 1
 * * < 0: keypad application mode disabled
 * appcursor value:
 * * 0: no value
 * * > 0: cursor application mode enabled
 * * < 0: cursor application mode disabled
 *
 * Be careful with the order of the definitions because st searches in
 * this table sequentially, so any XK_ANY_MOD must be in the last
 * position for a key.
 */

 /*
  * If you want keys other than the X11 function keys (0xFD00 - 0xFFFF)
  * to be mapped below, add them to this array.
  */
static KeySym mappedkeys[] = { -1 };

/*
 * State bits to ignore when matching key or button events.  By default,
 * numlock (Mod2Mask) and keyboard layout (XK_SWITCH_MOD) are ignored.
 */
static uint ignoremod = Mod2Mask | XK_SWITCH_MOD;

/*
 * This is the huge key array which defines all compatibility to the Linux
 * world. Please decide about changes wisely.
 */
static Key key[] = {
  /* keysym           mask         string         appkey appcursor */
  { XK_KP_Home,       Sft,         "\033[2J",     0,    -1},
  { XK_KP_Home,       Sft,         "\033[1;2H",   0,    +1},
  { XK_KP_Home,       Any,         "\033[H",      0,    -1},
  { XK_KP_Home,       Any,         "\033[1~",     0,    +1},
  { XK_KP_Up,         Any,         "\033Ox",     +1,     0},
  { XK_KP_Up,         Any,         "\033[A",      0,    -1},
  { XK_KP_Up,         Any,         "\033OA",      0,    +1},
  { XK_KP_Down,       Any,         "\033Or",     +1,     0},
  { XK_KP_Down,       Any,         "\033[B",      0,    -1},
  { XK_KP_Down,       Any,         "\033OB",      0,    +1},
  { XK_KP_Left,       Any,         "\033Ot",     +1,     0},
  { XK_KP_Left,       Any,         "\033[D",      0,    -1},
  { XK_KP_Left,       Any,         "\033OD",      0,    +1},
  { XK_KP_Right,      Any,         "\033Ov",     +1,     0},
  { XK_KP_Right,      Any,         "\033[C",      0,    -1},
  { XK_KP_Right,      Any,         "\033OC",      0,    +1},
  { XK_KP_Prior,      Sft,         "\033[5;2~",   0,     0},
  { XK_KP_Prior,      Any,         "\033[5~",     0,     0},
  { XK_KP_Begin,      Any,         "\033[E",      0,     0},
  { XK_KP_End,        Ctr,         "\033[J",     -1,     0},
  { XK_KP_End,        Ctr,         "\033[1;5F",  +1,     0},
  { XK_KP_End,        Sft,         "\033[K",     -1,     0},
  { XK_KP_End,        Sft,         "\033[1;2F",  +1,     0},
  { XK_KP_End,        Any,         "\033[4~",     0,     0},
  { XK_KP_Next,       Sft,         "\033[6;2~",   0,     0},
  { XK_KP_Next,       Any,         "\033[6~",     0,     0},
  { XK_KP_Insert,     Sft,         "\033[2;2~",  +1,     0},
  { XK_KP_Insert,     Sft,         "\033[4l",    -1,     0},
  { XK_KP_Insert,     Ctr,         "\033[L",     -1,     0},
  { XK_KP_Insert,     Ctr,         "\033[2;5~",  +1,     0},
  { XK_KP_Insert,     Any,         "\033[4h",    -1,     0},
  { XK_KP_Insert,     Any,         "\033[2~",    +1,     0},
  { XK_KP_Delete,     Ctr,         "\033[M",     -1,     0},
  { XK_KP_Delete,     Ctr,         "\033[3;5~",  +1,     0},
  { XK_KP_Delete,     Sft,         "\033[2K",    -1,     0},
  { XK_KP_Delete,     Sft,         "\033[3;2~",  +1,     0},
  { XK_KP_Delete,     Any,         "\033[3~",    -1,     0},
  { XK_KP_Delete,     Any,         "\033[3~",    +1,     0},
  { XK_KP_Multiply,   Any,         "\033Oj",     +2,     0},
  { XK_KP_Add,        Any,         "\033Ok",     +2,     0},
  { XK_KP_Enter,      Any,         "\033OM",     +2,     0},
  { XK_KP_Enter,      Any,         "\r",         -1,     0},
  { XK_KP_Subtract,   Any,         "\033Om",     +2,     0},
  { XK_KP_Decimal,    Any,         "\033On",     +2,     0},
  { XK_KP_Divide,     Any,         "\033Oo",     +2,     0},
  { XK_KP_0,          Any,         "\033Op",     +2,     0},
  { XK_KP_1,          Any,         "\033Oq",     +2,     0},
  { XK_KP_2,          Any,         "\033Or",     +2,     0},
  { XK_KP_3,          Any,         "\033Os",     +2,     0},
  { XK_KP_4,          Any,         "\033Ot",     +2,     0},
  { XK_KP_5,          Any,         "\033Ou",     +2,     0},
  { XK_KP_6,          Any,         "\033Ov",     +2,     0},
  { XK_KP_7,          Any,         "\033Ow",     +2,     0},
  { XK_KP_8,          Any,         "\033Ox",     +2,     0},
  { XK_KP_9,          Any,         "\033Oy",     +2,     0},
  { XK_Up,            Sft,         "\033[1;2A",   0,     0},
  { XK_Up,            Alt,         "\033[1;3A",   0,     0},
  { XK_Up,            Sft|Alt,     "\033[1;4A",   0,     0},
  { XK_Up,            Ctr,         "\033[1;5A",   0,     0},
  { XK_Up,            Sft|Ctr,     "\033[1;6A",   0,     0},
  { XK_Up,            Ctr|Alt,     "\033[1;7A",   0,     0},
  { XK_Up,            Sft|Ctr|Alt, "\033[1;8A",   0,     0},
  { XK_Up,            Any,         "\033[A",      0,    -1},
  { XK_Up,            Any,         "\033OA",      0,    +1},
  { XK_Down,          Sft,         "\033[1;2B",   0,     0},
  { XK_Down,          Alt,         "\033[1;3B",   0,     0},
  { XK_Down,          Sft|Alt,     "\033[1;4B",   0,     0},
  { XK_Down,          Ctr,         "\033[1;5B",   0,     0},
  { XK_Down,          Sft|Ctr,     "\033[1;6B",   0,     0},
  { XK_Down,          Ctr|Alt,     "\033[1;7B",   0,     0},
  { XK_Down,          Sft|Ctr|Alt, "\033[1;8B",   0,     0},
  { XK_Down,          Any,         "\033[B",      0,    -1},
  { XK_Down,          Any,         "\033OB",      0,    +1},
  { XK_Left,          Sft,         "\033[1;2D",   0,     0},
  { XK_Left,          Alt,         "\033[1;3D",   0,     0},
  { XK_Left,          Sft|Alt,     "\033[1;4D",   0,     0},
  { XK_Left,          Ctr,         "\033[1;5D",   0,     0},
  { XK_Left,          Sft|Ctr,     "\033[1;6D",   0,     0},
  { XK_Left,          Ctr|Alt,     "\033[1;7D",   0,     0},
  { XK_Left,          Sft|Ctr|Alt, "\033[1;8D",   0,     0},
  { XK_Left,          Any,         "\033[D",      0,    -1},
  { XK_Left,          Any,         "\033OD",      0,    +1},
  { XK_Right,         Sft,         "\033[1;2C",   0,     0},
  { XK_Right,         Alt,         "\033[1;3C",   0,     0},
  { XK_Right,         Sft|Alt,     "\033[1;4C",   0,     0},
  { XK_Right,         Ctr,         "\033[1;5C",   0,     0},
  { XK_Right,         Sft|Alt,     "\033[1;6C",   0,     0},
  { XK_Right,         Ctr|Alt,     "\033[1;7C",   0,     0},
  { XK_Right,         Sft|Ctr|Alt, "\033[1;8C",   0,     0},
  { XK_Right,         Any,         "\033[C",      0,    -1},
  { XK_Right,         Any,         "\033OC",      0,    +1},
  { XK_ISO_Left_Tab,  Sft,         "\033[Z",      0,     0},
  { XK_Return,        Alt,         "\033\r",      0,     0},
  { XK_Return,        Any,         "\r",          0,     0},
  { XK_Insert,        Sft,         "\033[4l",    -1,     0},
  { XK_Insert,        Sft,         "\033[2;2~",  +1,     0},
  { XK_Insert,        Ctr,         "\033[L",     -1,     0},
  { XK_Insert,        Ctr,         "\033[2;5~",  +1,     0},
  { XK_Insert,        Any,         "\033[4h",    -1,     0},
  { XK_Insert,        Any,         "\033[2~",    +1,     0},
  { XK_Delete,        Ctr,         "\033[M",     -1,     0},
  { XK_Delete,        Ctr,         "\033[3;5~",  +1,     0},
  { XK_Delete,        Sft,         "\033[2K",    -1,     0},
  { XK_Delete,        Sft,         "\033[3;2~",  +1,     0},
  { XK_Delete,        Any,         "\033[3~",    -1,     0},
  { XK_Delete,        Any,         "\033[3~",    +1,     0},
  { XK_BackSpace,     Nom,         "\177",        0,     0},
  { XK_BackSpace,     Alt,         "\033\177",    0,     0},
  { XK_Home,          Sft,         "\033[2J",     0,    -1},
  { XK_Home,          Sft,         "\033[1;2H",   0,    +1},
  { XK_Home,          Any,         "\033[H",      0,    -1},
  { XK_Home,          Any,         "\033[1~",     0,    +1},
  { XK_End,           Ctr,         "\033[J",     -1,     0},
  { XK_End,           Ctr,         "\033[1;5F",  +1,     0},
  { XK_End,           Sft,         "\033[K",     -1,     0},
  { XK_End,           Sft,         "\033[1;2F",  +1,     0},
  { XK_End,           Any,         "\033[4~",     0,     0},
  { XK_Prior,         Ctr,         "\033[5;5~",   0,     0},
  { XK_Prior,         Sft,         "\033[5;2~",   0,     0},
  { XK_Prior,         Any,         "\033[5~",     0,     0},
  { XK_Next,          Ctr,         "\033[6;5~",   0,     0},
  { XK_Next,          Sft,         "\033[6;2~",   0,     0},
  { XK_Next,          Any,         "\033[6~",     0,     0},
  { XK_F1,            Nom,         "\033OP" ,     0,     0},
  { XK_F1, /* F13 */  Sft,         "\033[1;2P",   0,     0},
  { XK_F1, /* F25 */  Ctr,         "\033[1;5P",   0,     0},
  { XK_F1, /* F37 */  Sup,         "\033[1;6P",   0,     0},
  { XK_F1, /* F49 */  Alt,         "\033[1;3P",   0,     0},
  { XK_F1, /* F61 */  Mo3,         "\033[1;4P",   0,     0},
  { XK_F2,            Nom,         "\033OQ" ,     0,     0},
  { XK_F2, /* F14 */  Sft,         "\033[1;2Q",   0,     0},
  { XK_F2, /* F26 */  Ctr,         "\033[1;5Q",   0,     0},
  { XK_F2, /* F38 */  Sup,         "\033[1;6Q",   0,     0},
  { XK_F2, /* F50 */  Alt,         "\033[1;3Q",   0,     0},
  { XK_F2, /* F62 */  Mo3,         "\033[1;4Q",   0,     0},
  { XK_F3,            Nom,         "\033OR" ,     0,     0},
  { XK_F3, /* F15 */  Sft,         "\033[1;2R",   0,     0},
  { XK_F3, /* F27 */  Ctr,         "\033[1;5R",   0,     0},
  { XK_F3, /* F39 */  Sup,         "\033[1;6R",   0,     0},
  { XK_F3, /* F51 */  Alt,         "\033[1;3R",   0,     0},
  { XK_F3, /* F63 */  Mo3,         "\033[1;4R",   0,     0},
  { XK_F4,            Nom,         "\033OS" ,     0,     0},
  { XK_F4, /* F16 */  Sft,         "\033[1;2S",   0,     0},
  { XK_F4, /* F28 */  Ctr,         "\033[1;5S",   0,     0},
  { XK_F4, /* F40 */  Sup,         "\033[1;6S",   0,     0},
  { XK_F4, /* F52 */  Alt,         "\033[1;3S",   0,     0},
  { XK_F5,            Nom,         "\033[15~",    0,     0},
  { XK_F5, /* F17 */  Sft,         "\033[15;2~",  0,     0},
  { XK_F5, /* F29 */  Ctr,         "\033[15;5~",  0,     0},
  { XK_F5, /* F41 */  Sup,         "\033[15;6~",  0,     0},
  { XK_F5, /* F53 */  Alt,         "\033[15;3~",  0,     0},
  { XK_F6,            Nom,         "\033[17~",    0,     0},
  { XK_F6, /* F18 */  Sft,         "\033[17;2~",  0,     0},
  { XK_F6, /* F30 */  Ctr,         "\033[17;5~",  0,     0},
  { XK_F6, /* F42 */  Sup,         "\033[17;6~",  0,     0},
  { XK_F6, /* F54 */  Alt,         "\033[17;3~",  0,     0},
  { XK_F7,            Nom,         "\033[18~",    0,     0},
  { XK_F7, /* F19 */  Sft,         "\033[18;2~",  0,     0},
  { XK_F7, /* F31 */  Ctr,         "\033[18;5~",  0,     0},
  { XK_F7, /* F43 */  Sup,         "\033[18;6~",  0,     0},
  { XK_F7, /* F55 */  Alt,         "\033[18;3~",  0,     0},
  { XK_F8,            Nom,         "\033[19~",    0,     0},
  { XK_F8, /* F20 */  Sft,         "\033[19;2~",  0,     0},
  { XK_F8, /* F32 */  Ctr,         "\033[19;5~",  0,     0},
  { XK_F8, /* F44 */  Sup,         "\033[19;6~",  0,     0},
  { XK_F8, /* F56 */  Alt,         "\033[19;3~",  0,     0},
  { XK_F9,            Nom,         "\033[20~",    0,     0},
  { XK_F9, /* F21 */  Sft,         "\033[20;2~",  0,     0},
  { XK_F9, /* F33 */  Ctr,         "\033[20;5~",  0,     0},
  { XK_F9, /* F45 */  Sup,         "\033[20;6~",  0,     0},
  { XK_F9, /* F57 */  Alt,         "\033[20;3~",  0,     0},
  { XK_F10,           Nom,         "\033[21~",    0,     0},
  { XK_F10, /* F22 */ Sft,         "\033[21;2~",  0,     0},
  { XK_F10, /* F34 */ Ctr,         "\033[21;5~",  0,     0},
  { XK_F10, /* F46 */ Sup,         "\033[21;6~",  0,     0},
  { XK_F10, /* F58 */ Alt,         "\033[21;3~",  0,     0},
  { XK_F11,           Nom,         "\033[23~",    0,     0},
  { XK_F11, /* F23 */ Sft,         "\033[23;2~",  0,     0},
  { XK_F11, /* F35 */ Ctr,         "\033[23;5~",  0,     0},
  { XK_F11, /* F47 */ Sup,         "\033[23;6~",  0,     0},
  { XK_F11, /* F59 */ Alt,         "\033[23;3~",  0,     0},
  { XK_F12,           Nom,         "\033[24~",    0,     0},
  { XK_F12, /* F24 */ Sft,         "\033[24;2~",  0,     0},
  { XK_F12, /* F36 */ Ctr,         "\033[24;5~",  0,     0},
  { XK_F12, /* F48 */ Sup,         "\033[24;6~",  0,     0},
  { XK_F12, /* F60 */ Alt,         "\033[24;3~",  0,     0},
  { XK_F13,           Nom,         "\033[1;2P",   0,     0},
  { XK_F14,           Nom,         "\033[1;2Q",   0,     0},
  { XK_F15,           Nom,         "\033[1;2R",   0,     0},
  { XK_F16,           Nom,         "\033[1;2S",   0,     0},
  { XK_F17,           Nom,         "\033[15;2~",  0,     0},
  { XK_F18,           Nom,         "\033[17;2~",  0,     0},
  { XK_F19,           Nom,         "\033[18;2~",  0,     0},
  { XK_F20,           Nom,         "\033[19;2~",  0,     0},
  { XK_F21,           Nom,         "\033[20;2~",  0,     0},
  { XK_F22,           Nom,         "\033[21;2~",  0,     0},
  { XK_F23,           Nom,         "\033[23;2~",  0,     0},
  { XK_F24,           Nom,         "\033[24;2~",  0,     0},
  { XK_F25,           Nom,         "\033[1;5P",   0,     0},
  { XK_F26,           Nom,         "\033[1;5Q",   0,     0},
  { XK_F27,           Nom,         "\033[1;5R",   0,     0},
  { XK_F28,           Nom,         "\033[1;5S",   0,     0},
  { XK_F29,           Nom,         "\033[15;5~",  0,     0},
  { XK_F30,           Nom,         "\033[17;5~",  0,     0},
  { XK_F31,           Nom,         "\033[18;5~",  0,     0},
  { XK_F32,           Nom,         "\033[19;5~",  0,     0},
  { XK_F33,           Nom,         "\033[20;5~",  0,     0},
  { XK_F34,           Nom,         "\033[21;5~",  0,     0},
  { XK_F35,           Nom,         "\033[23;5~",  0,     0},
};

/*
 * Selection types' masks.
 * Use the same masks as usual.
 * Button1Mask is always unset, to make masks match between ButtonPress.
 * ButtonRelease and MotionNotify.
 * If no match is found, regular selection is used.
 */
static uint selmasks[] = {
  [SEL_RECTANGULAR] = Alt,     
};

/*
 * Printable characters in ASCII, used to estimate the advance width
 * of single wide characters.
 */
static char ascii_printable[] =
" !\"#$%&'()*+,-./0123456789:;<=>?"
"@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_"
"`abcdefghijklmnopqrstuvwxyz{|}~";
