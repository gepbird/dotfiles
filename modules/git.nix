self: { ... }:

{
  hm-gep.programs.git = {
    enable = true;
    aliases = {
      c = "commit";
      ca = "commit --amend";
      can = "commit --amend --no-edit";
      cp = "cherry-pick";
      m = "merge";
      ri = "rebase -i";
      rc = "rebase --continue";
      ra = "rebase --abort";
      st = "stash --include-untracked";
      sp = "stash pop";
      sd = "stash drop";
      sl = "stash list";
      ss = "stash show 0 -p";
      s = "status";
      b = "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]' --sort=-committerdate";
      bir = "bisect reset";
      big = "bisect good";
      bib = "bisect bad";
      biv = "bisect view --oneline";
      bil = "bisect log";
      d = "diff";
      ds = "diff --staged";
      co = "checkout";
      cob = "checkout -b";
      f = "fetch";
      cl = "clone --recursive";
      gh = "!_() { git clone --recursive git@github.com:$1 \${@:2}; }; _";
      pr = "!_() { git fetch upstream pull/$1/head:pr-$1 && git checkout pr-$1; }; _";
      pf = "push --force";
      l = "log --pretty=format:'%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]' --abbrev-commit -30";
      churl = "remote set-url origin";
    };
    extraConfig = {
      user = {
        name = "Gutyina Gergő";
        email = "gutyina.gergo.2@gmail.com";
        signingKey = "~/.ssh/id_ed25519.pub";
      };
      init.defaultBranch = "main";
      safe.directory = "*";
      core.editor = "nvim";
      gpg.format = "ssh";
      commit.gpgSign = true;
      push.autoSetupRemote = true;
      pull.rebase = true;
    };
  };
}
