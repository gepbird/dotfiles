self: { ... }:

{
  services.pipewire = {
    alsa.enable = true; # required for osu!
    enable = true;
    pulse.enable = true;
  };

  # make less audio stutters when high gpu+cpu usage by buffering and delaying audio by ~30ms 
  # disabled because it causes audio desync in osu!
  #environment.etc = {
  #  "pipewire/pipewire.conf.d/90-bigger-buffer.conf".text = ''
  #    context.properties = {
  #      default.clock.rate = 48000
  #      default.clock.min-quantum = 1500
  #      default.clock.max-quantum = 1500
  #    }
  #  '';
  #};
}
