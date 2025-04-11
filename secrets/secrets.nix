let
  inherit (builtins)
    attrNames
    listToAttrs
    readDir
    removeAttrs
    ;

  ssh-module = import ../modules/ssh.nix null { };
  keys = ssh-module.users.users.gep.openssh.authorizedKeys.keys;

  secretFiles = attrNames (removeAttrs (readDir (toString ./.)) [ "secrets.nix" ]);
  result = listToAttrs (
    map (x: {
      name = x;
      value = {
        publicKeys = keys;
      };
    }) secretFiles
  );
in
result
