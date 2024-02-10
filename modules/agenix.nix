{ agenix, ... }:

{
  imports = [ agenix.nixosModules.default ];
  hm.home.packages = [ agenix.packages.x86_64-linux.default ];

  age = {
    secrets = {
      system-password.file = ../secrets/system-password.age;
    };
  };
}
