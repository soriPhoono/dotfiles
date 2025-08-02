{python3Packages}:
with python3Packages;
  buildPythonApplication {
    pname = "server-bot";
    version = "1.0";

    pyproject = true;
    build-system = [setuptools];
    propagatedBuildInputs = [discordpy];

    src = ./.;
  }
