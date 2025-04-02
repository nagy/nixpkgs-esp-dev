{
  config,
  pkgs,
  lib,
  ...
}:

let
  root = import ../. { pkgs = pkgs; };
  cfg = config.programs.esp-idf;
in
{
  options.programs.esp-idf = {
    enable = lib.mkEnableOption "esp-idf";
  };

  config = lib.mkIf cfg.enable {

    environment.systemPackages = [
      root.esp-idf-esp32
      pkgs.cmake
      pkgs.gnumake
    ];

    environment.variables = {
      IDF_PATH = root.esp-idf-esp32.outPath;
      IDF_TOOLS_PATH = root.esp-idf-esp32.outPath + "/tools";
      IDF_PYTHON_ENV_PATH = root.esp-idf-esp32.outPath + "/python-env";
      IDF_PYTHON_CHECK_CONSTRAINTS = "no";
    };

  };
}
