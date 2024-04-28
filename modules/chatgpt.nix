self: { config, pkgs, lib, ... }:

let
  configuration = {
    api_key = "@secret@";
    conversation = {
      model = "gpt-4-turbo";
    };
  };
  runConfigPath = "/run/chatgpt-config.json";
in
{
  hm-gep.home.packages = [ pkgs.chatgpt-cli ];

  hm-gep.xdg.configFile."chatgpt/config.json".source =
    config.hm-gep.lib.file.mkOutOfStoreSymlink runConfigPath;

  system.activationScripts."chatgpt-secret" = ''
    secret=$(cat ${config.age.secrets.openai-token.path})
    echo '${builtins.toJSON configuration}' \
      | ${lib.getExe pkgs.gnused} "s#@secret@#$secret#" \
      > ${runConfigPath}
    chown ${config.users.users.gep.name} ${runConfigPath}
    chmod 400 ${runConfigPath}
  '';
}
