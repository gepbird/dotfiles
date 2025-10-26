self:
{
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) getExe;
  ripgrep = self.lib.maybeCachePackage self pkgs.ripgrep;
in
{
  hm-gep.programs.git = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.git;
    settings = {
      alias = {
        c = "commit";
        ca = "commit --amend";
        can = "commit --amend --no-edit";
        cs = "commit --all";
        chp = "cherry-pick";
        m = "merge";
        ma = "merge --abort";
        ri = "rebase -i";
        rc = "rebase --continue";
        ra = "rebase --abort";
        st = "stash --include-untracked";
        sp = "stash pop";
        sd = "stash drop";
        sl = "stash list";
        ss = "stash show 0 -p";
        s = "status";
        b = "branch --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]'";
        bir = "bisect reset HEAD";
        big = "bisect good";
        bib = "bisect bad";
        biv = "bisect view --oneline";
        bil = "bisect log";
        d = "diff";
        dw = "diff --word-diff";
        ds = "diff --staged";
        co = "checkout";
        cob = "checkout -b";
        f = "fetch";
        cl = "clone --recursive";
        gh = "!_() { git clone --recursive git@github.com:$1 \${@:2}; }; _";
        pl = "pull";
        ps = "push";
        psf = "push --force-with-lease";
        l = "log --pretty=format:'%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]' --abbrev-commit -30";
        lg = "!_() { git log --oneline | ${getExe ripgrep} \"$*\"; }; _";
      };
      user = {
        name = "Gutyina Gergő";
        email = "gutyina.gergo.2@gmail.com";
        signingKey = "~/.ssh/id_ed25519.pub";
      };
      init.defaultBranch = "main";
      safe.directory = "*";
      core.editor = "nvim";
      core.untrackedcache = true;
      core.fsmonitor = true;
      gpg.format = "ssh";
      commit.gpgSign = true;
      push.autoSetupRemote = true;
      pull.rebase = true;
      rerere.enabled = true;
      branch.sort = "-committerdate";
    };
  };

  hm-gep.home.packages =
    with pkgs;
    self.lib.maybeCachePackages self [
      git-extras
    ];
}
