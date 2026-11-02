{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ffmpeg_7-full
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-vaapi
    gst_all_1.gst-libav
    libreoffice
    hunspell
    hunspellDicts.pl_PL
    hunspellDicts.en_US
    wireshark
    corefonts
    calibre
    audacity
    kdePackages.kdenlive
    gimp

    steam-run
    steamcmd
  ];
  programs.gphoto2.enable = true;
}
