{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  home-manager.users.gep = {
    home.file = {
      # use manual symlinking for nvim, configuring it with slow rebuild time is pain
      #".config/nvim/ftplugin".source = ./home/.config/nvim/ftplugin;
      #".config/nvim/lua".source = ./home/.config/nvim/lua;
      #".config/nvim/init.lua".source = ./home/.config/nvim/init.lua;
      #".config/nvim/.luarc.json".source = ./home/.config/nvim/.luarc.json;
      ".omnisharp".source = ./home/.omnisharp;
    };

    home.packages = with pkgs; [
      gcc
      gnumake
      rustc
      cargo
      php
      php83Packages.composer
      python3
      python311Packages.pip
      nodejs
      #openjdk8
      openjdk19
      gradle
      dotnet-sdk
      flutter
      sqlite
      dbeaver
    ];
  };
}
