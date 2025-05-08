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
    # geppc
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKGW5zKjn01DVf6vTs/D2VV+/awXTNboY1iaCThi2A1v gep@geppc"
    # gepphone
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHQXysKutq2b67RAmq46qMH8TDLEYf0D5SYon4vE6efO u0_a483@localhost"
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
