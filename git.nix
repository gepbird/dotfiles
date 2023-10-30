{ home-manager, ... }:

{
  home-manager.users.gep = {
    programs.git = {
      enable = true;
      aliases = {
        c = "commit -S";
        ca = "commit -S --amend";
        st = "stash --include-untracked";
        sp = "stash pop";
        s = "status";
        b = "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate";
        d = "diff";
        ds = "diff --staged";
        co = "checkout";
        cl = "clone --recursive";
        gh = "!git clone --recursive git@github.com:$1";
        p = "!git pull && git push";
        l = "log --pretty=format:'%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]' --abbrev-commit -30";
        churl = "remote set-url origin";
        cp = "cherry-pick";
      };
      extraConfig = {
        user = {
          name = "Gutyina Gergő";
          email = "gutyina.gergo.2@gmail.com";
          signingKey = "~/.ssh/id_ed25519.pub";
        };
        init.defaultBranch = "main";
        core.editor = "nvim";
        gpg.format = "ssh";
        push.autoSetupRemote = true;
        pull.rebase = true;
      };
    };
  };
}
