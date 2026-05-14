{
  ...
}:

{
  nix.settings = {
    substituters = [
      "https://nix-cache.tchfoo.com"
    ];
    trusted-public-keys = [
      "nix-cache.tchfoo.com-1:pWK4l0phRA3bE0CviZodEQ5mWAQYoiuVi2LML+VNtNY="
    ];
  };
}
