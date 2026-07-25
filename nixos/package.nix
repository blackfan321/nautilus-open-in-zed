{
  lib,
  stdenv,
  python3,
  nautilus-python,
  src,
}:

stdenv.mkDerivation {
  pname = "nautilus-open-in-zed";
  version = "0.0.1";

  inherit src;

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
    homepage = "https://github.com/hrbtk/nautilus-open-in-zed";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
