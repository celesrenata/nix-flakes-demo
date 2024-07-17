final: prev:
{
  freerdp3Override = prev.freerdp3.overrideAttrs (old: {
      pname = "freerdp";
      version = "3.6.3";
    src = prev.fetchFromGitHub {
      owner = "FreeRDP";
      repo = "FreeRDP";
      rev = "ffe75ce7b1cec71716139d4b01cf46fb5cab3ed0";
      sha256 = "sha256-LdgHQ2lb3cde4cX4aIwHvSo0q9iwpLzaWDHbv1/rneE=";
    };
  });
}
