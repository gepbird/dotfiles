self:
{
  ...
}:

{
  # enabled by default in graphical-desktop module
  services.speechd.enable = false;

  services.pipewire = {
    restartOnConfigChange = true;
    extraConfig.pipewire."99-mono-sink" = {
      "context.modules" = [
        {
          name = "libpipewire-module-loopback";
          args = {
            "node.description" = "Mono Playback Device";
            "capture.props" = {
              "node.name" = "mono-sink";
              "media.class" = "Audio/Sink";
              "audio.position" = [ "MONO" ];
            };
            "playback.props" = {
              "node.name" = "mono-sink.output";
              "audio.position" = [ "MONO" ];
              "node.passive" = true;
            };
          };
        }
      ];
    };
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
