final: prev:
rec {
  end-4-dots = prev.stdenv.mkDerivation {
    pname = "end-4-dots";
    version = "0.1";
    src = prev.fetchFromGitHub {
      owner = "celesrenata";
      repo = "dots-hyprland";
      rev = "09d597cbe710452e5f1e20c7658d2677cdab4554";
      sha256 = "sha256-VCGL8p8WTPbja4wjvzZDj0N8e93e5wf0DUiVD9yLCUk=";
    };
    
    installPhase = ''
      install -m755 -D .local/bin/fuzzel-emoji $out/.local/bin/fuzzel-emoji
      install -m755 -D .local/bin/initialSetup.sh $out/.local/bin/initialSetup.sh
      cd .config
      find ags -type f | awk '{ print "install -m755 -D " $0 " $out/" $0 }' | bash
      find anyrun -type f | awk '{ print "install -m755 -D " $0 " $out/" $0 }' | bash
      find fish -type f | awk '{ print "install -m755 -D " $0 " $out/" $0 }' | bash
      find foot -type f | awk '{ print "install -m755 -D " $0 " $out/" $0 }' | bash
      #find fontconfig -type f | awk '{ print "install -m755 -D " $0 " $out/" $0 }' | bash
      find hypr -type f | awk '{ print "install -m755 -D " $0 " $out/" $0 }' | bash
      find mpv -type f | awk '{ print "install -m755 -D " $0 " $out/" $0 }' | bash
      find qt5ct -type f | awk '{ print "install -m755 -D " $0 " $out/" $0 }' | bash
      find wlogout -type f | awk '{ print "install -m755 -D " $0 " $out/" $0 }' | bash
      find zshrc.d -type f | awk '{ print "install -m755 -D " $0 " $out/" $0 }' | bash
      install -m755 -D starship.toml $out/.config/starship.toml
      install -m755 -D thorium-flags.conf $out/.config/thorium-flags.conf
    '';
  };
}
