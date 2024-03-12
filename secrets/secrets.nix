let
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL6/2MNWBfc/D9LgtrpHADj487KMNAwZ0RliXNCVpyGo root@geptop"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK4t5Q+D/J7QdvsqTD8saryirJDbTm/kymLumToDqsHw root@geppc"
  ];
in
{
  "system-password.age".publicKeys = keys;
  "openai-token.age".publicKeys = keys;
}
