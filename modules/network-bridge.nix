{
  ...
}:

# this is a quick and very broken way of making a network bridge for
# putting VM traffic on my home network
# known issues:
# - internet disconnects every ~10-30 minutes (maybe dhcp doesnt work?), workaround is activating the config without bridges then activating this config
# - the usual local addresses are broken, I could only ssh to my VM by forwarding it through the router and using its public address
{
  networking.bridges = {
    br0 = {
      interfaces = [ "enp2s0" ];
      rstp = false; # Enable this if you need Rapid Spanning Tree Protocol
    };
  };

  # Disable DHCP on the enp2s0 interface
  networking.interfaces.enp2s0.useDHCP = false; # Disable DHCP for the physical interface

  # Configure DHCP for the bridge interface (br0)
  networking.interfaces.br0 = {
    useDHCP = true; # This is where we enable DHCP for the bridge.
  };
}
