# Home Manager Module
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # C/C++
    gnumake cmake gcc 

    # Rust: rustup
    rustup

    # Python: uv
    (buildFHSEnv {
      name = "uv";
      runScript = "uv";
      targetPkgs = _: [ stdenv.cc.cc zlib uv ];
    })

    # Python: pixi
    (buildFHSEnv {
      name = "pixi";
      runScript = "pixi";
      targetPkgs = _: [ stdenv.cc.cc zlib pixi ];
    })
  ];

}
