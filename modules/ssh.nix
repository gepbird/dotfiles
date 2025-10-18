self:
{
  pkgs,
  ...
}:

{
  services.openssh = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.openssh;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      X11Forwarding = true;
    };
  };

  users.users.gep.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID799rcrUU09obAHEqsXteQxPYIedCFlFr3tf0XDDowM gep@geptop-xmg"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAbDt4o2HwPry7W6q71ccF2xcBb8+w4V3MUG4Q7z/+vC root@geptop-xmg"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKGW5zKjn01DVf6vTs/D2VV+/awXTNboY1iaCThi2A1v gep@geppc"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDrg9sldIBPgx4Jxpa+OZBQGX/ej4rMoi/q7M+48mLYa root@geppc"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID3olHivyTuztxmwefBJ5EtsaG2Kff7kDGVUacrFMIFQ gep@raspi-doboz"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGp3MDIeetPKbS95IkRhQm/4Q1tRKd8iVKBcNaWR2TIk gep@raspi5-doboz"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAI7atY2/1xxvfFA8UvieoZg2UHpcnQ7u/IaMbA3OJB4 gep@gepphone"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM5plUDJC9i4F1FG7+lZvWFyYDhse98E94usal1yr3gE gep@gepwin"
  ];

  hm-gep.programs.ssh = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.openssh;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        extraOptions.StrictHostKeyChecking = "no";
      };
      "raspi.tchfoo.com" = {
        port = 42727;
        forwardX11 = true;
        forwardX11Trusted = true;
      };
      "raspi5.tchfoo.com" = {
        port = 42728;
        forwardX11 = true;
        forwardX11Trusted = true;
      };
    };
  };

  hm-gep.services.ssh-agent = {
    enable = true;
  };

  nixpkgs.overlays = [
    (self.lib.maybeCachePackageOverlay self "openssh")
  ];
}
