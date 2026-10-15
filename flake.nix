{
	description = "My system configurations";
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
	  flake-utils.url = "github:numtide/flake-utils";
		home-manager = {
				url = "github:nix-community/home-manager/release-26.05";
				inputs.nixpkgs.follows = "nixpkgs";
		};
		
		firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
		
		
	};
	outputs = { nixpkgs, home-manager, self, flake-utils, ... } @inputs:	
		let
			system = "x86_64-linux";
			outputs = self;   
		in {
		  nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
          ./configuration.nix
        	home-manager.nixosModules.home-manager {
						home-manager = {
						useUserPackages = true;
						useGlobalPkgs = true;
						extraSpecialArgs = { inherit inputs;}; 
						users.pepe = import ./home-manager/home.nix;
						backupFileExtension = "backup";
						};
          }
                   
        ];
        specialArgs = {
          inherit inputs outputs;
        };
		  };	
			flake-utils.lib.eachDefaultSystem = (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        # devShells.default = import ./shell.nix {inherit pkgs;};
        formatter = nixpkgs.legacyPackages.${system}.alejandra;
      }
     );
		};
}