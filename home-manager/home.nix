{config, pkgs, inputs, ...}:{
    imports = [
        ./modules/default.nix
    ];

     #_module.args = {
     #    inherit inputs;
    #};

     #extraSpecialArgs = {
     #};

    home.username = "pepe";
    home.homeDirectory = "/home/pepe";
    home.stateVersion = "26.05";

    programs.bash = {
        enable = true;
        shellAliases = {
            rebuild = "sudo nixos-rebuild switch --flake ./";
        };
    };

}