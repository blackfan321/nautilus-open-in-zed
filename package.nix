{
  lib,
  stdenv,
  python3,
  nautilus-python,
  fetchFromGitHub,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "nautilus-open-in-zed";
  version = "unstable-2025-07-01";

  src = fetchFromGitHub {
    owner = "blackfan321";
    repo = finalAttrs.pname;
    rev = "dd88ce5c90d8223025cdc69c8c34de4aab87fb41";
    hash = "sha256-QD8KFMrKrwgoA3UMI9pJAS2hGvdMGkVPuynLe6RmbtM=";
  };

  # Zed is shipped as `zeditor`, not `zed`
  patches = [ ./zed-exec-name.patch ];

  buildInputs = [
    nautilus-python
    python3.pkgs.pygobject3
  ];

  installPhase = ''
    runHook preInstall
    install -Dm555 ./nautilus-open-in-zed.py -t $out/share/nautilus-python/extensions
    runHook postInstall
  '';

  meta = with lib; {
    description = "Nautilus extension that adds an context-entry for opening in Zed";
    homepage = "https://github.com/blackfan321/nautilus-open-in-zed";
    license = licenses.mit;
    platforms = platforms.linux;
  };
})
