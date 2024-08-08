{ lib
, fetchFromGitHub
, # pythonOlder,
  python312
, # build-system
  # hatchling,

}:

python312.pkgs.buildPythonPackage rec {
  pname = "litestar";
  version = "v2.16.2";
  pyproject = true;

  # disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "litestar-org";
    repo = "polyfactory";
    rev = "refs/tags/${version}";
    hash = "sha256-W08sz66jnAAWuLIwB0X77PqCuBvUKiJ/kE0Nwn0vPsQ=";
  };

  build-system = [ python312.pkgs.hatchling ];

  dependencies = [
    python312.pkgs.faker
    python312.pkgs.typing-extensions
  ];

  optional-dependencies.all =
    [
      python312.pkgs.sqlalchemy
      python312.pkgs.msgspec
    ]
    ++ lib.optionals (lib.versionAtLeast python312.pkgs.pydantic.version "2") [
      python312.pkgs.pydantic
      python312.pkgs.pydantic-settings
      python312.pkgs.pydantic-extra-types
    ];

  doCheck = false;
  pythonImportsCheck = [ ];

}

