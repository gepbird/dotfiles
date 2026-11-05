self:
{
  pkgs,
  ...
}:

{
  hm-gep.programs.delta = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.delta;
    enableGitIntegration = true;
    options = {
      hunk-header-decoration-style = "ul";
    };
  };

  nixpkgs.overlays = [
    (final: prev: {
      delta = prev.delta.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          # TODO: remove when fixed: https://github.com/dandavison/delta/issues/2316
          (prev.fetchpatch2 {
            name = "fix-crash-with-weird-utf-8-characters.patch";
            url = "https://github.com/gepbird/delta/compare/3c2269c6b845913965575f11b0196d70ef5352f3...846042f67878eed142723911d8cadd2717fe47d2.patch?full_index=1";
            hash = "sha256-vcMCPsl0oCmwDdkTklJQQaXnF9XVa2S6/cj0et/wmuk=";
          })
        ];
      });
    })
  ];
}
