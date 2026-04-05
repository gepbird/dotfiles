self:
{
  pkgs,
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

  programs.ssh.extraConfig = ''
    IdentityFile /etc/ssh/ssh_host_ed25519_key
  '';

  users.users.gep.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID799rcrUU09obAHEqsXteQxPYIedCFlFr3tf0XDDowM gep@geptop-xmg"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAbDt4o2HwPry7W6q71ccF2xcBb8+w4V3MUG4Q7z/+vC root@geptop-xmg"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJJSiOYxVIEi0pFsTVLWrIEw48u97+I6NnsCo7uI9MA9 gep@geppc-2"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPF1+QvkqS0jAw0q+lRDmN8OtY4ADKm1CxsVnBzGYfZL root@geppc-2"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID3olHivyTuztxmwefBJ5EtsaG2Kff7kDGVUacrFMIFQ gep@raspi-doboz"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGp3MDIeetPKbS95IkRhQm/4Q1tRKd8iVKBcNaWR2TIk gep@raspi5-doboz"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDPvctVPA1R8A9t9BceYHJeTqIJc4Rkp0NnP5IPqJnUv gep@gepphone"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM5plUDJC9i4F1FG7+lZvWFyYDhse98E94usal1yr3gE gep@gepwin"
  ];

  hm-gep.programs.ssh = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.openssh;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        extraOptions.StrictHostKeyChecking = "no";
        identityFile = "~/.ssh/id_ed25519";
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
}
