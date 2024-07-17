{pkgs, ...}: {
  hardware.firmware = [
    (stdenvNoCC.mkDerivation (final: {
      name = "brcm-firmware";
      src = ../resources/firmware.tar;

      dontUnpack = true;
      installPhase = ''
        mkdir -p $out/lib/firmware/brcm
        tar -xf ${final.src} -C $out/lib/firmware/brcm
      '';
    }))
  ];
}
