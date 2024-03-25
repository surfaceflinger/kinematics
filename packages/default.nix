{ self, inputs, ... }:
{
  perSystem =
    { system, pkgs, ... }:
    {
      packages = {
        # re-export our packages
        inherit (pkgs)
          ambuild
          cssds
          cssds-assets
          hl2sdk-css
          kinematics
          metamod-css
          sourcemod-css
          ;
      };
      # make pkgs available to all `perSystem` functions
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          self.overlays.default
          inputs.steam-fetcher.overlays.default
        ];
      };
    };

  flake.overlays.default =
    _final: prev:
    let
      pkgsi686 = if _final.system == "x86_64-linux" then _final.pkgsi686Linux else _final.pkgsCross.gnu32;
    in
    {
      # Custom packages
      ambuild = prev.python3Packages.callPackage ./ambuild { };
      cssds-assets = prev.callPackage ./cssds-assets { };
      cssds = pkgsi686.callPackage ./cssds { inherit (_final) fetchSteam; };
      hl2sdk-css = prev.callPackage ./hl2sdk-css { };
      kinematics = prev.callPackage ./kinematics { };
      metamod-css = pkgsi686.callPackage ./metamod-css { };
      sourcemod-css = pkgsi686.callPackage ./sourcemod-css { };
    };
}
