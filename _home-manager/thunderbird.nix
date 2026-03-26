/*
  #+TITLE: Thunderbird - email client
  #+FILETAGS: :program:
*/
{ ... }:

{
  programs.thunderbird = {
    enable = true;
    settings = { };
    profiles.me = {
      isDefault = true;
    };
  };
}
