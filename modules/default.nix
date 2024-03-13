{ self, ... }:

{
  imports = builtins.attrValues self.nixosModules;
}
