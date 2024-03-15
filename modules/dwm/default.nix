{ pkgs, lib, ... }:

{
  services.xserver.windowManager.dwm = {
    enable = true;
    package = with lib; with pkgs; dwm.overrideAttrs (_: {
      src = ./dwm;
      postPatch = ''
        substituteInPlace chbright.sh \
          --replace '@hck@' '${getExe hck}' \
          --replace '@dunstify@' '${getExe' dunst "dunstify"}' \
          --replace '@light@' '${getExe light}'
        substituteInPlace chvol.sh \
          --replace '@sed@' '${getExe gnused}' \
          --replace '@rg@' '${getExe ripgrep}' \
          --replace '@dunstify@' '${getExe' dunst "dunstify"}' \
          --replace '@pactl@' '${getExe' pulseaudio "pactl"}'
        substituteInPlace config.def.h \
          --replace '@zsh@' '${getExe zsh}' \
          --replace '@clac@' '${getExe clac}' \
          --replace '@lf@' '${getExe lf}' \
          --replace '@chatgpt@' '${getExe chatgpt-cli}' \
          --replace '@btm@' '${getExe bottom}' \
          --replace '@xkill@' '${getExe xorg.xkill}' \
          --replace '@rofi@' '${getExe rofi}' \
          --replace '@flameshot@' '${getExe flameshot}' \
          --replace '@gromit-mpx@' '${getExe gromit-mpx}' \
          --replace '@xfce4-terminal@' '${getExe xfce.xfce4-terminal}'
      '';
      buildInputs = [ wrapGAppsHook ];
    });
  };
}
