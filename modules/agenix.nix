self: { agenix, ... }:

{
  imports = [ agenix.nixosModules.default ];
  hm-gep.home.packages = [ agenix.packages.x86_64-linux.default ];

  age = {
    secrets = {
      system-password.file = ../secrets/system-password.age;
      openai-token.file = ../secrets/openai-token.age;
    };
  };
}
