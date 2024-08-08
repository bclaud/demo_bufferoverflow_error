{ python312Packages, litestar }:
with python312Packages;
buildPythonApplication {
  pname = "demo_error";
  version = "1.0";
  pyproject = true;

  build-system = [ python312Packages.poetry-core ];

  dependencies = [ litestar python312Packages.uvicorn python312Packages.httptools python312Packages.uvloop ];

  src = ./.;

  meta = {
    mainProgram = "demo-error";
  };
}
