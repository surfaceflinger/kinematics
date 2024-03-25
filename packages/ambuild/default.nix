{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
}:

buildPythonPackage rec {
  pname = "ambuild";
  version = "0-unstable-2024-02-29";

  src = fetchFromGitHub {
    owner = "alliedmodders";
    repo = pname;
    rev = "03aa2e00cc8b772e1d2fa2c03ab7dff861e85f40";
    hash = "sha256-j+FxihQt69BZmgV9yds35+H8o9ALgsOJV+2y0QtLkBs=";
  };

  meta = with lib; {
    homepage = "https://github.com/alliedmodders/ambuild";
    description = "AMBuild is a lightweight build system designed for performance and accuracy";
    license = licenses.bsd3;
  };
}
