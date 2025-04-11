let
  ssh-module = import ../modules/ssh.nix null { };
  keys = ssh-module.users.users.gep.openssh.authorizedKeys.keys;
in
{
  "system-password.age".publicKeys = keys;
  "openai-token.age".publicKeys = keys;
}
