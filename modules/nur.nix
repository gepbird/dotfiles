self:
{
  ...
}:

{
  nixpkgs.overlays = [
    self.inputs.nur.overlays.default
  ];
}
