{ ... }:

{
  services.udiskie = {
    enable = true;
  };
  /*
  Unlock the killswitch device (shut off udev rule) with keyfile
  */
  # home.file.".config/udiskie/config.yml".text = ''
  #   device_config:
  #     - id_uuid: b3ec2286-cc94-4540-b5bc-3446fabb2242
  #     - keyfile: $HOME/.config/udiskie/killswitch_random_keyfile
  # '';
  # xdg.configFile."udiskie/killswitch_random_keyfile".source = "${_secret}/killswitch_random_keyfile";
}
