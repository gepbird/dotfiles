self:
{
  pkgs,
  ...
}:

{
  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      texlab

      #texlive.combined.scheme-full
    ]
    ++ [
      (texlive.withPackages (
        ps: with ps; [
          scheme-basic

          latexmk

          #collection-mathscience
          naive-ebnf # fixes tikz.sty not found
          siunitx
          steinmetz # required for \phasor

          circuitikz
          collection-fontsrecommended
          enumitem
          environ
          listings
          pict2e # required for \phasor
          soul
          titlesec
          wrapfig
          xstring
        ]
      ))
    ];
}
