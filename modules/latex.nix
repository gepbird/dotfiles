{ pkgs, ... }:

{
  hm.home.packages = with pkgs; [
    #texlive.combined.scheme-full

    (texlive.withPackages (ps: with ps; [
      scheme-basic

      latexmk

      #collection-mathscience
      naive-ebnf # fixes tikz.sty not found
      siunitx
      steinmetz # required for \phasor

      circuitikz
      enumitem
      environ
      pict2e # required for \phasor
      soul
      xstring
    ]))
  ];
}
