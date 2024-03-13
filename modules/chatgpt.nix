{ config, pkgs, ... }:

let
  jsonFormat = pkgs.formats.json { };
in
{
  hm.home.packages = [ pkgs.chatgpt-cli ];

  hm.xdg.configFile."chatgpt/config.json".source = jsonFormat.generate "config.json" {
    api_key = builtins.readFile config.age.secrets.openai-token.path;
    conversation = {
      model = "gpt-4-turbo-preview";
    };
  };
}
