{
  clangStdenv,
  fetchFromGitHub,
  hl2sdk-css,
  ambuild,
  metamod-css,
  zlib,
}:

clangStdenv.mkDerivation {
  pname = "sourcemod-css";
  version = "0-unstable-2024-03-07";

  src = fetchFromGitHub {
    owner = "alliedmodders";
    repo = "sourcemod";
    rev = "dbec0b165c7ed70acdbb03b3b471de8a25f3ec2b";
    hash = "sha256-1hzRW4TJtJ9iIQtyIbptOrMvmUY71NhutILgFP4shLA=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ ambuild ];
  buildInputs = [ zlib ];

  buildPhase = ''
    ln -s ${hl2sdk-css} hl2sdk-css
    ln -s ${metamod-css}/include metamod-source
    mkdir build
    cd build
    python ../configure.py --sdks css --no-mysql --enable-optimize --disable-auto-versioning
    ambuild
  '';

  installPhase = ''
    mkdir -p $out
    mv package $out/share
  '';
}
