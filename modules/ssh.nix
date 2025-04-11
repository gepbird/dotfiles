self:
{
  ...
}:

{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = true;
    };
  };

  users.users.gep.openssh.authorizedKeys.keys = [
    # geptop
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDPWyW2tBcCORf4C/Z7iPaKGoiswyLdds3m8ZrNY8OXl gutyina.gergo.2@gmail.com"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL6/2MNWBfc/D9LgtrpHADj487KMNAwZ0RliXNCVpyGo root@geptop"
    # geppc
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKGW5zKjn01DVf6vTs/D2VV+/awXTNboY1iaCThi2A1v gep@geppc"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDrg9sldIBPgx4Jxpa+OZBQGX/ej4rMoi/q7M+48mLYa root@nixos"
    # gepphone
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHQXysKutq2b67RAmq46qMH8TDLEYf0D5SYon4vE6efO u0_a483@localhost"
  ];

  hm-gep.programs.ssh = {
    enable = true;
    matchBlocks."*".extraOptions.StrictHostKeyChecking = "no";
  };

  hm-gep.services.ssh-agent = {
    enable = true;
  };
}
