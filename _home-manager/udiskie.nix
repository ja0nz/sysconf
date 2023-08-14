/* #+TITLE: Udiskie - automounter for removeable media
   #+FILETAGS: :hardware:

   * Mandatory configuration
    You need to enable udisks2
    nixOS: services.udisks2.enable = true;
   * Optional configuration
    You can configure a usb stick a *killswitch* device
    https://tech.michaelaltfield.net/2020/01/02/buskill-laptop-kill-cord-dead-man-switch/
    Just set an udev rule and here (optional) unlock it by keyfile
*/
{ ... }:

{
  services.udiskie = { enable = true; };
  # Unlock the killswitch device (shut off udev rule) with keyfile
  # home.file.".config/udiskie/config.yml".text = ''
  #   device_config:
  #     - id_uuid: b3ec2286-cc94-4540-b5bc-3446fabb2242
  #     - keyfile: $HOME/.config/udiskie/killswitch_random_keyfile
  # '';
  # xdg.configFile."udiskie/killswitch_random_keyfile".source = "${../_secret}/killswitch_random_keyfile";
}
