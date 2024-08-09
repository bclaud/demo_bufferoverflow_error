{ lib
, fetchFromGitHub
, # pythonOlder,
  python312
, # build-system
  # hatchling,

  # dependencies
  # anyio,
  # httpx,
  # exceptiongroup,
  # importlib-metadata,
  # importlib-resources,
  # msgspec,
  # multidict,
  polyfactory
, # pyyaml,
  # typing-extensions,
  # click,
  # rich,
  # rich-click,

  #optional-dependencies
  # uvicorn,
  # pydantic,
  # pydantic-settings,
  # pydantic-extra-types,
}:

python312.pkgs.buildPythonPackage rec {
  pname = "litestar";
  version = "v2.10.0";
  pyproject = true;

  # disabled = pythonOlder "3.7";

  src = ./litestar;

  build-system = [ python312.pkgs.hatchling ];

  dependencies = [
    python312.pkgs.anyio
    python312.pkgs.httpx
    python312.pkgs.exceptiongroup
    python312.pkgs.importlib-metadata
    python312.pkgs.importlib-resources
    python312.pkgs.msgspec
    python312.pkgs.multidict
    python312.pkgs.pyyaml
    python312.pkgs.typing-extensions
    python312.pkgs.click
    python312.pkgs.rich
    python312.pkgs.rich-click
    polyfactory
  ];

  optional-dependencies.all =
    [
      python312.pkgs.uvicorn
    ]
    ++ lib.optionals (lib.versionAtLeast python312.pkgs.pydantic.version "2") [
      python312.pkgs.pydantic-settings
      python312.pkgs.pydantic-extra-types
    ]
    ++ python312.pkgs.uvicorn.optional-dependencies.standard;

  doCheck = false;
  pythonImportsCheck = [ ];

}



# litestar dependencies
# x means it's not at nixpkgs
# dependencies = [
#   "anyio>=3",
#   "httpx>=0.22",
#   "exceptiongroup; python_version < \"3.11\"",
#   "importlib-metadata; python_version < \"3.10\"",
#   "importlib-resources>=5.12.0; python_version < \"3.9\"",
#   "msgspec>=0.18.2",
#   "multidict>=6.0.2",
#   "polyfactory>=2.6.3", X
#   "pyyaml",
#   "typing-extensions",
#   "click",
#   "rich>=13.0.0",
#   "rich-click",
# ]

# optional dependencies
# I'll deal with it latter
# [project.optional-dependencies]
# annotated-types = ["annotated-types"]
# attrs = ["attrs"]
# brotli = ["brotli"]
# cli = ["jsbeautifier", "uvicorn[standard]", "uvloop>=0.18.0; sys_platform != 'win32'"]
# cryptography = ["cryptography"]
# full = [
#   "litestar[annotated-types,attrs,brotli,cli,cryptography,jinja,jwt,mako,minijinja,opentelemetry,piccolo,picologging,prometheus,pydantic,redis,sqlalchemy,standard,structlog]",
# ]
# jinja = ["jinja2>=3.1.2"]
# jwt = ["python-jose", "cryptography"]
# mako = ["mako>=1.2.4"]
# minijinja = ["minijinja>=1.0.0"]
# opentelemetry = ["opentelemetry-instrumentation-asgi"]
# piccolo = ["piccolo"]
# picologging = ["picologging"]
# prometheus = ["prometheus-client"]
# pydantic = ["pydantic", "email-validator", "pydantic-extra-types"]
# redis = ["redis[hiredis]>=4.4.4"]
# sqlalchemy = ["advanced-alchemy>=0.2.2"]
# standard = ["jinja2", "jsbeautifier", "uvicorn[standard]", "uvloop>=0.18.0; sys_platform != 'win32'", "fast-query-parsers>=1.0.2"]
# structlog = ["structlog"]
