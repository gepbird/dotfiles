self: {...}:

{
  hm-gep.home.packages = [
    (import self.inputs.nixpkgs-stylelint-lsp { }).stylelint-lsp
  ];
}
