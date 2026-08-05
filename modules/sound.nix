self:
{
  ...
}:

{
  # enabled by default in graphical-desktop module
  services.speechd.enable = false;

  # extra "Mono" output device that downmixes both channels into one and plays it
  # on both, for videos where the audio is only on one channel
  # switch between it and the real device in pavucontrol's Output Devices tab
  services.pipewire.extraConfig.pipewire."99-mono-sink" = {
    "context.modules" = [
      {
        name = "libpipewire-module-loopback";
        args = {
          "node.description" = "Mono";
          "capture.props" = {
            "node.name" = "mono-sink";
            "media.class" = "Audio/Sink";
            "audio.position" = [
              "FL"
              "FR"
            ];
          };
          # follows the default sink, so it keeps working when switching headphones/speakers
          "playback.props" = {
            "node.name" = "mono-sink.output";
            "audio.position" = [ "MONO" ];
            "node.passive" = true;
          };
        };
      }
    ];
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
