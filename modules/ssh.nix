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
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAI7atY2/1xxvfFA8UvieoZg2UHpcnQ7u/IaMbA3OJB4 u0_a288@localhost"
    # gepwin
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM5plUDJC9i4F1FG7+lZvWFyYDhse98E94usal1yr3gE gep@DESKTOP-3LEAJ4K"
  ];

  hm-gep.programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        extraOptions.StrictHostKeyChecking = "no";
      };
      "raspi.tchfoo.com" = {
        port = 42727;
        forwardX11 = true;
        forwardX11Trusted = true;
      };
    };
  };

  hm-gep.services.ssh-agent = {
    enable = true;
  };
}
