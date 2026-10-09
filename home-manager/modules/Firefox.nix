{ inputs, pkgs, outputs,  ... }: 
let
  firefox-extension = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
            ublock-origin
            bitwarden
            darkreader
            vimium
          ];

 in 
{

  programs.firefox = {
    enable = true;
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
          settings = {
            "browser.startup.homepage" = "https://google.com";
            "browser.search.defaultenginename" = "Google";
            "browser.search.order.1" = "Google";
          };
          search = {
            force = true;
            default = "Google";
            order = [ "Google" ];
            engines = {
              "Nix Packages" = {
                urls = [{
                  template = "https://search.org/packages";
                  params = [
                    { name = "type"; value = "packages"; }
                    { name = "query"; value = "{searchTerms}"; }
                  ];
                }];
                icon = "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                definedAliases = [ "@np" ];
              };
              "NixOS Wiki" = {
                urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = [ "@nw" ];
              };
              "Searx" = {
                urls = [{ template = "https://searx.aicampground.com/?q={searchTerms}"; }];
                iconUpdateURL = "https://nixos.wiki/favicon.png";
                updateInterval = 24 * 60 * 60 * 1000; # every day
                definedAliases = [ "@searx" ];
              };
              "Bing".metaData.hidden = true;
              "Google".metaData.alias = "@g"; 
            };
          };
        
        extensions =  {
          force = true;
  
          packages = firefox-extension;
        };
        };
      }; 
   };
}