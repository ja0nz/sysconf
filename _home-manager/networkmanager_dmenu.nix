{ pkgs, ... }:

{
  home.packages = with pkgs; [
    networkmanager_dmenu # Manage NetworkManager connections with dmenu/rofi/wofi instead of nm-applet
  ];
  home.file.".config/networkmanager-dmenu/config.ini".text = ''
    [dmenu]
    dmenu_command = ${pkgs.fuzzel}/bin/fuzzel --match-mode exact --dmenu
    active_chars = ==
    compact = False
    pinentry = ${pkgs.pinentry-gnome3}/bin/pinentry
    wifi_icons = 󰤯󰤟󰤢󰤥󰤨
    format = {name:<{max_len_name}s}  {sec:<{max_len_sec}s} {icon:>4}
    list_saved = False
    prompt = Networks

    [pinentry]
    description = Network password
    prompt = Password:

    [editor]
    terminal = ${pkgs.foot}/bin/footclient
    gui_if_available = True
    gui = ${pkgs.networkmanagerapplet}/bin/nm-connection-editor

    [nmdm]
    rescan_delay = 5
  '';
}
