self:
{
  pkgs,
  ...
}:

let
  # TODO: remove when fixed: https://github.com/ente-io/ente/issues/4536
  ente-auth = pkgs.ente-auth.overrideAttrs (o: {
    prePatch = ''
      substituteInPlace lib/utils/directory_utils.dart \
        --replace-fail "return cacheHome" "return Directory(p.join(cacheHome.path, 'enteauthinit'));"
    '';
  });
in
{
  hm-gep.home.packages = [ ente-auth ];

  services.gnome.gnome-keyring.enable = true;
}
