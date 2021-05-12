/* #+TITLE: Zathura - a document viewer
   #+FILETAGS: :program:

   * Optional configuration
    Add your config
*/
{ ... }:

{
  programs.zathura = {
    enable = true;
    extraConfig = builtins.readFile ./zathurarc; # TODO Optional config
  };
}
