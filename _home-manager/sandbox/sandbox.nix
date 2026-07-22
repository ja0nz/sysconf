/*
  #+TITLE: Sandbox
  #+FILETAGS: :cli:

  A quick sandbox for trying out dangerous things
  Jail.nix could also be put in devShells

  Additional to the ./default.nix for putting this to home.packages
  I will leave another ./adhoc.nix for
  nix-build adhoc.nix -> ./result/bin/sandbox

  * Mandatory configuration

  * Optional configuration
    Additional combinators:
    https://alexdav.id/projects/jail-nix/combinators
*/
{ pkgs, jail }:
let
  c = jail.combinators;

  launcher = pkgs.writeShellApplication {
    name = "sandbox-launcher";
    runtimeInputs = [ pkgs.fish ];
    text = ''
      if [ "$#" -gt 0 ]; then exec "$@"; else exec fish; fi
    '';
  };

  baseCombinators = [
    c.no-new-session
    (c.fwd-env "PATH")
    (c.readonly "/nix")
    (c.readonly "/run/current-system")
    (c.try-readonly (c.noescape "~/.nix-profile"))
    c.network
    c.mount-cwd
  ];

  mkSandbox = name: extra: jail name "${launcher}/bin/sandbox-launcher" (baseCombinators ++ extra);

  sandboxPlain = mkSandbox "sandbox" [ ];
  sandboxGpu = mkSandbox "sandbox-gpu" [ c.gpu ];
  sandboxGui = mkSandbox "sandbox-gui" [
    c.gpu
    c.gui
  ];

  dispatcher = pkgs.writeShellApplication {
    name = "sandbox";
    text = ''
      case "''${1:-}" in
        --gpu) shift; exec ${sandboxGpu}/bin/sandbox-gpu "$@" ;;
        --gui) shift; exec ${sandboxGui}/bin/sandbox-gui "$@" ;;
        *)     exec ${sandboxPlain}/bin/sandbox "$@" ;;
      esac
    '';
  };
in
dispatcher
