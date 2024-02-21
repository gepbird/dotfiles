{ pkgs, ... }:

{
  hm.home.packages = with pkgs; [
    cargo
    cargo-watch
    dotnet-sdk
    flutter
    gcc
    gnumake
    nodejs
    php
    php83Packages.composer
    rustc
    sqlite
  ];
}
