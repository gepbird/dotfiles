/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx = 2;        /* border pixel of windows */
static const unsigned int snap = 32;           /* snap pixel */
static const int showbar = 1;                  /* 0 means no bar */
static const int topbar = 1;                   /* 0 means bottom bar */
static const char* fonts[] = { "monospace:size=10" };
static const char dmenufont[] = "monospace:size=10";
static const char col_gray1[] = "#222222";
static const char col_gray2[] = "#444444";
static const char col_gray3[] = "#bbbbbb";
static const char col_gray4[] = "#eeeeee";
static const char col_cyan[] = "#005577";
static const char col_green[] = "#00aa55";
static const char* colors[][3] = {
  /*               fg         bg         border   */
  [SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
  [SchemeSel] = { col_gray4, col_cyan,  col_green },
};

/* tagging */
static const char* tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
  /* xprop(1):
   *	WM_CLASS(STRING) = instance, class
   *	WM_NAME(STRING) = title
   */
   /* class                       instance  title           tags mask  isfloating  monitor */
   { "discord"                   ,NULL     ,NULL           ,1 << 0    ,0          ,1 },
   { "Microsoft Teams - Preview" ,NULL     ,NULL           ,1 << 1    ,0          ,1 },
   { "Chromium"                  ,NULL     ,NULL           ,1 << 2    ,0          ,1 },
   { "flameshot"                 ,NULL     ,NULL           ,0         ,1          ,-1 },
   { NULL                        ,NULL     ,"Event Tester" ,0         ,1          ,-1 },
};

/* layout(s) */
static const float mfact = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
  /* symbol  arrange function */
  { "[T]",   tile },    /* first entry is default */
  { "[F]",   NULL },    /* no layout function means floating behavior */
  { "[M]",   monocle },
};

#include <X11/XF86keysym.h>

/* key definitions */
#define Alt Mod1Mask
#define Control ControlMask
#define Shift ShiftMask
#define Super Mod4Mask
#define VolToggle XF86XK_AudioMute
#define VolDown XF86XK_AudioLowerVolume
#define VolUp XF86XK_AudioRaiseVolume
#define BrightDown XF86XK_MonBrightnessDown
#define BrightUp XF86XK_MonBrightnessUp

#define TAGKEYS(KEY,TAG) \
  { Super                   ,KEY ,view       ,{.ui = 1 << TAG} }, \
  { Super | Control         ,KEY ,toggleview ,{.ui = 1 << TAG} }, \
  { Super | Shift           ,KEY ,tag        ,{.ui = 1 << TAG} }, \
  { Super | Control | Shift ,KEY ,toggletag  ,{.ui = 1 << TAG} },

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char* dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char* termcmd[] = { "st", "-e", "fish", NULL };
static const char* flameshotfull[] = { "flameshot", "full", "--clipboard", NULL };
static const char* flameshotgui[] = { "flameshot", "gui", NULL };
static const char* flameshotguidelayed[] = { "flameshot", "gui", "-d", "2500", NULL };
static const char* voltoggle[] = { "pactl", "set-sink-mute", "0", "toggle", NULL };
static const char* voldown[] = { "pactl", "set-sink-volume", "0", "-10%", NULL };
static const char* voldown_little[] = { "pactl", "set-sink-volume", "0", "-1%", NULL };
static const char* volup[] = { "pactl", "set-sink-volume", "0", "+10%", NULL };
static const char* volup_little[] = { "pactl", "set-sink-volume", "0", "+1%", NULL };
static const char* brightdown[] = { "backlight_control", "-10", NULL };
static const char* brightdown_little[] = { "backlight_control", "-1", NULL };
static const char* brightup[] = { "backlight_control", "+10", NULL };
static const char* brightup_little[] = { "backlight_control", "+1", NULL };

static Key keys[] = {
  /* modifier               key         function        argument */
  {  Super                 ,XK_p       ,spawn          ,{ .v = dmenucmd } },
  {  Super                 ,XK_Return  ,spawn          ,{ .v = termcmd } },
  {  0                     ,XK_Print   ,spawn          ,{ .v = flameshotfull } },
  {  Control               ,XK_Print   ,spawn          ,{ .v = flameshotgui } },
  {  Control | Shift       ,XK_Print   ,spawn          ,{ .v = flameshotguidelayed } },
  {  Super                 ,XK_b       ,togglebar      ,{ 0 } },
  {  Super                 ,XK_j       ,focusstack     ,{ .i = +1 } },
  {  Super                 ,XK_k       ,focusstack     ,{ .i = -1 } },
  {  Super                 ,XK_i       ,incnmaster     ,{ .i = +1 } },
  {  Super                 ,XK_d       ,incnmaster     ,{ .i = -1 } },
  {  Super                 ,XK_h       ,setmfact       ,{ .f = -0.05 } },
  {  Super                 ,XK_l       ,setmfact       ,{ .f = +0.05 } },
  {  Super                 ,XK_Tab     ,zoom           ,{ 0 } },
  {  Alt                   ,XK_Tab     ,viewnext,       { 0 } },
  {  Alt | Shift           ,XK_Tab     ,viewprev,       { 0 } },
  {  Alt | Control         ,XK_Tab     ,tagtonext,      { 0 } },
  {  Alt | Control | Shift ,XK_Tab     ,tagtoprev,      { 0 } },
  {  Super                 ,XK_q       ,killclient     ,{ 0 } },
  {  Super                 ,XK_t       ,setlayout      ,{ .v = &layouts[0] } },
  {  Super                 ,XK_f       ,setlayout      ,{ .v = &layouts[1] } },
  {  Super                 ,XK_m       ,setlayout      ,{ .v = &layouts[2] } },
  {  Super                 ,XK_g       ,togglefloating ,{ 0 } },
  {  Super                 ,XK_0       ,view           ,{ .ui = ~0 } },
  {  Super | Shift         ,XK_0       ,tag            ,{ .ui = ~0 } },
  {  Super | Shift         ,XK_j       ,focusmon       ,{ .i = -1 } },
  {  Super | Shift         ,XK_k       ,focusmon       ,{ .i = +1 } },
  {  Super | Shift         ,XK_h       ,tagmon         ,{ .i = -1 } },
  {  Super | Shift         ,XK_l       ,tagmon         ,{ .i = +1 } },
  {  Super | Shift         ,XK_q       ,quit           ,{ 0 } },
  {  0                     ,BrightUp   ,spawn          ,{ .v = brightup } },
  {  Shift                 ,BrightUp   ,spawn          ,{ .v = brightup_little } },
  {  0                     ,BrightDown ,spawn          ,{ .v = brightdown } },
  {  Shift                 ,BrightDown ,spawn          ,{ .v = brightdown_little } },
  {  0                     ,VolToggle  ,spawn          ,{ .v = voltoggle } },
  {  0                     ,VolDown    ,spawn          ,{ .v = voldown } },
  {  Shift                 ,VolDown    ,spawn          ,{ .v = voldown_little } },
  {  0                     ,VolUp      ,spawn          ,{ .v = volup } },
  {  Shift                 ,VolUp      ,spawn          ,{ .v = volup_little } },
  TAGKEYS(XK_1, 0)
  TAGKEYS(XK_2, 1)
  TAGKEYS(XK_3, 2)
  TAGKEYS(XK_4, 3)
  TAGKEYS(XK_5, 4)
  TAGKEYS(XK_6, 5)
  TAGKEYS(XK_7, 6)
  TAGKEYS(XK_8, 7)
  TAGKEYS(XK_9, 8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
  /* click         event mask  button   function        argument */
  { ClkLtSymbol   ,0          ,Button1 ,setlayout      ,{ 0 } },
  { ClkLtSymbol   ,0          ,Button3 ,setlayout      ,{ .v = &layouts[2] } },
  { ClkWinTitle   ,0          ,Button2 ,zoom           ,{ 0 } },
  { ClkStatusText ,0          ,Button2 ,spawn          ,{ .v = termcmd } },
  { ClkClientWin  ,Super      ,Button1 ,movemouse      ,{ 0 }, },
  { ClkClientWin  ,Super      ,Button2 ,togglefloating ,{ 0 }, },
  { ClkClientWin  ,Super      ,Button3 ,resizemouse    ,{ 0 }, },
  { ClkTagBar     ,0          ,Button1 ,view           ,{ 0 } },
  { ClkTagBar     ,0          ,Button3 ,toggleview     ,{ 0 } },
  { ClkTagBar     ,Super      ,Button1 ,tag            ,{ 0 }, },
  { ClkTagBar     ,Super      ,Button3 ,toggletag      ,{ 0 }, },
};

