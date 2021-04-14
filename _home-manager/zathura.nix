{ config, ... }:

{
  programs.zathura = {
    enable = true;
    extraConfig = builtins.readFile (config._static + /zathurarc);
  };
}
