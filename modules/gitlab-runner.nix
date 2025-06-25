self:
{
  config,
  pkgs,
  ...
}:

{
  services.gitlab-runner = {
    enable = true;
    services.work-test = {
      authenticationTokenConfigFile =
        config.age.secrets.gitlab-runner-work-test.path
          or (toString (pkgs.writeText "gitlab-runner-work-test" ""));
      executor = "shell";
    };
    extraPackages = with pkgs; [
      git
    ];
  };

  # https://github.com/NixOS/nixpkgs/issues/420039
  environment.systemPackages = config.services.gitlab-runner.extraPackages;
}
