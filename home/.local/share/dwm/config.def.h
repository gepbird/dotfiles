/* See LICENSE file for copyright and license details. */

/* appearance */
static unsigned int borderpx        = 3;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "monospace:size=10" };
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char col_green[]       = "#00aa55";
static const char *colors[][3]      = {
  /*               fg         bg         border   */
  [SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
  [SchemeSel]  = { col_gray4, col_cyan,  col_green },
};

typedef struct {
  const char *name;
  const void *cmd;
} Sp;
#define SP(tag, cmd) \
  { tag, (char *[]) { "xfce4-terminal", "--geometry", "120x34", "-T", tag, "-e", cmd, NULL } },
static Sp scratchpads[] = {
  /* name          cmd  */
  SP("spterm",     "zsh")
  SP("spclac",     "clac")
  SP("splf",       "lf")
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
  /* xprop(1):
   *  WM_CLASS(STRING) = instance, class
   *  WM_NAME(STRING) = title
   */
  /* class       instance    title       tags mask     isfloating   monitor */
  { "discord",   NULL,       NULL,       1 << 0,       0,           1  },
  { "firefox",   NULL,       NULL,       1 << 1,       0,           1  },
  { "flameshot", NULL,       NULL,       0,            1,           1  },
  { NULL,        NULL,       "spterm",   SPTAG(0),     1,           -1 },
  { NULL,        NULL,       "spclac",   SPTAG(1),     1,           -1 },
  { NULL,        NULL,       "splf",     SPTAG(2),     1,           -1 },
};

/* layout(s) */
static const float mfact        = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster        = 1;    /* number of clients in master area */
static const int resizehints    = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1;    /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
  /* symbol     arrange function */
  { "[T]",      tile },    /* first entry is default */
  { "[F]",      NULL },    /* no layout function means floating behavior */
  { "[M]",      monocle },
};

/* key definitions */
#include <X11/XF86keysym.h>
#define Alt Mod1Mask
#define Sup Mod4Mask
#define Ctr ControlMask
#define Sft ShiftMask
#define VolToggle XF86XK_AudioMute
#define VolDown XF86XK_AudioLowerVolume
#define VolUp XF86XK_AudioRaiseVolume
#define BrightDown XF86XK_MonBrightnessDown
#define BrightUp XF86XK_MonBrightnessUp

#define TAGKEYS(KEY,TAG) \
  { Sup,                          KEY,      view,           { .ui = 1 << TAG } }, \
  { Sup|Ctr,                      KEY,      toggleview,     { .ui = 1 << TAG } }, \
  { Sup|Sft,                      KEY,      tag,            { .ui = 1 << TAG } }, \
  { Sup|Ctr|Sft,                  KEY,      toggletag,      { .ui = 1 << TAG } },

/* commands */
static const char *rofi[]             = { "rofi", "-show", "run", NULL };
static const char *term[]             = { "xfce4-terminal", NULL };
static const char *flameshot[]        = { "flameshot", "gui", NULL };
static const char *flameshotdelayed[] = { "flameshot", "gui", "-d", "2500", NULL };
static const char *xkill[]            = { "xkill", NULL };
static const char* voltoggle[]        = { "chvol.sh", "set-sink-mute", "0", "toggle", NULL };
static const char* voldown[]          = { "chvol.sh", "set-sink-volume", "0", "-10%", NULL };
static const char* voldownlite[]      = { "chvol.sh", "set-sink-volume", "0", "-1%", NULL };
static const char* volup[]            = { "chvol.sh", "set-sink-volume", "0", "+10%", NULL };
static const char* voluplite[]        = { "chvol.sh", "set-sink-volume", "0", "+1%", NULL };
static const char* brightdown[]       = { "chbright.sh", "0.7", NULL };
static const char* brightdownlite[]   = { "chbright.sh", "0.9", NULL };
static const char* brightup[]         = { "chbright.sh", "1.3", NULL };
static const char* brightuplite[]     = { "chbright.sh", "1.1", NULL };

static const Key keys[] = {
  /* modifier                     key         function        argument */
  { Sup,                          XK_p,       spawn,          { .v = rofi } },
  { Sup,                          XK_Return,  spawn,          { .v = term } },
  { 0,                            XK_Print,   spawn,          { .v = flameshot } },
  { Sft,                          XK_Print,   spawn,          { .v = flameshotdelayed } },
  { Sup,                          XK_b,       togglebar,      { 0 } },
  { Sup,                          XK_v,       toggleborder,   { 0 } },
  { Sup,                          XK_c,       incborder,      { .i = +1 } },
  { Sup,                          XK_x,       incborder,      { .i = -1 } },
  { Sup,                          XK_j,       focusstack,     { .i = +1 } },
  { Sup,                          XK_k,       focusstack,     { .i = -1 } },
  { Sup,                          XK_i,       incnmaster,     { .i = +1 } },
  { Sup,                          XK_d,       incnmaster,     { .i = -1 } },
  { Sup,                          XK_h,       setmfact,       { .f = -0.05 } },
  { Sup,                          XK_l,       setmfact,       { .f = +0.05 } },
  { Sup,                          XK_Tab,     zoom,           { 0 } },
  { Alt,                          XK_Tab,     viewnext,       { 0 } },
  { Alt|Sft,                      XK_Tab,     viewprev,       { 0 } },
  { Sup,                          XK_w,       spawn,          { .v = xkill } },
  { Sup,                          XK_q,       killclient,     { 0 } },
  { Sup|Sft,                      XK_q,       quit,           {0} },
  { Sup,                          XK_t,       setlayout,      { .v = &layouts[0] } },
  { Sup,                          XK_f,       setlayout,      { .v = &layouts[1] } },
  { Sup,                          XK_m,       setlayout,      { .v = &layouts[2] } },
  { Sup,                          XK_g,       togglefloating, { 0 } },
  { Sup|Sft,                      XK_k,       focusmon,       { .i = -1 } },
  { Sup|Sft,                      XK_j,       focusmon,       { .i = +1 } },
  { Sup|Sft,                      XK_h,       tagmon,         { .i = -1 } },
  { Sup|Sft,                      XK_l,       tagmon,         { .i = +1 } },
  { Sup,                          XK_z,       togglescratch,  { .ui = 0 } },
  { Sup,                          XK_u,       togglescratch,  { .ui = 1 } },
  { Sup,                          XK_o,       togglescratch,  { .ui = 2 } },
  { Sup,                          XK_0,       view,           { .ui = ~0 } },
  { Sup|Sft,                      XK_0,       tag,            { .ui = ~0 } },
  { 0,                            BrightUp,   spawn,          { .v = brightup } },
  { Sft,                          BrightUp,   spawn,          { .v = brightuplite } },
  { 0,                            BrightDown, spawn,          { .v = brightdown } },
  { Sft,                          BrightDown, spawn,          { .v = brightdownlite } },
  { 0,                            VolToggle,  spawn,          { .v = voltoggle } },
  { 0,                            VolDown,    spawn,          { .v = voldown } },
  { Sft,                          VolDown,    spawn,          { .v = voldownlite } },
  { 0,                            VolUp,      spawn,          { .v = volup } },
  { Sft,                          VolUp,      spawn,          { .v = voluplite } },
  TAGKEYS(                        XK_1,                       0)
  TAGKEYS(                        XK_2,                       1)
  TAGKEYS(                        XK_3,                       2)
  TAGKEYS(                        XK_4,                       3)
  TAGKEYS(                        XK_5,                       4)
  TAGKEYS(                        XK_6,                       5)
  TAGKEYS(                        XK_7,                       6)
  TAGKEYS(                        XK_8,                       7)
  TAGKEYS(                        XK_9,                       8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
  /* click                event mask      button          function        argument */
  { ClkLtSymbol,          0,              Button1,        setlayout,      { 0 } },
  { ClkLtSymbol,          0,              Button3,        setlayout,      { .v = &layouts[2] } },
  { ClkClientWin,         Sup,            Button1,        movemouse,      { 0 } },
  { ClkClientWin,         Sup,            Button2,        togglefloating, { 0 } },
  { ClkClientWin,         Sup,            Button3,        resizemouse,    { 0 } },
  { ClkTagBar,            0,              Button1,        view,           { 0 } },
  { ClkTagBar,            0,              Button3,        toggleview,     { 0 } },
  { ClkTagBar,            Sup,            Button1,        tag,            { 0 } },
  { ClkTagBar,            Sup,            Button3,        toggletag,      { 0 } },
};

