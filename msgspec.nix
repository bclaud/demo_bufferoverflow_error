{
  lib,
  python312,
  fetchFromGitHub,
}:

python312.pkgs.buildPythonPackage rec {
  pname = "msgspec";
  version = "0.18.6";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "jcrist";
    repo = "msgspec";
    rev = "refs/tags/${version}";
    hash = "sha256-xqtV60saQNINPMpOnZRSDnicedPSPBUQwPSE5zJGrTo=";
  };

  nativeBuildInputs = [ python312.pkgs.setuptools ];

  dependencies  = [ python312.pkgs.pyyaml python312.pkgs.tomli ];
  # Requires libasan to be accessible
  doCheck = false;

  pythonImportsCheck = [ "msgspec" ];

  meta = with lib; {
    description = "Module to handle JSON/MessagePack";
    homepage = "https://github.com/jcrist/msgspec";
    changelog = "https://github.com/jcrist/msgspec/releases/tag/${version}";
    license = licenses.bsd3;
    maintainers = with maintainers; [ fab ];
  };
}
