{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      extensions = with pkgs.vscode-extensions;
        [
          rust-lang.rust-analyzer
          jnoortheen.nix-ide
          pkief.material-product-icons
          pkief.material-icon-theme
        ];
    };
  };
}
