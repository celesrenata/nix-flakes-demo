final: prev: {
  jetbrains-toolboxOverride = prev.jetbrains-toolbox.overrideAttrs rec {
    meta.platforms = [ "aarch64-linux" ];
    version = "2.3.2.31487";
    src = fetchzip {
      url = "https://download.jetbrains.com/toolbox/jetbrains-toolbox-${version}-arm64.tar.gz";
      sha256 = "sha256-mrTEUp9DBSO1S6Nxx077lqtY847CiCBCCi/vboZ8ADs=";
      stripRoot = false;
    };
  }
}