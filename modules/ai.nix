self:
{
  config,
  lib,
  pkgs,
  ...
}:

{
  sops.secrets = {
    "gep/ai-api-keys/openrouter".owner = config.users.users.gep.name;
  };

  hm-gep.home.sessionVariables = lib.optionalAttrs config.enableSecrets {
    OPENROUTER_API_KEY = "$(cat ${config.secrets.gep.ai-api-keys.openrouter})";
  };

  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      llama-cpp-vulkan
      pi-coding-agent
    ];
}
