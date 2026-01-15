{
  stdenv,
  fetchurl,
  lib,
  makeWrapper,
  autoPatchelfHook,
  gtk3,
  libappindicator-gtk3,
  nss,
  nspr,
  xdg-utils,
  at-spi2-core,
  libdrm,
  libgbm,
  libxcb,
  pulseaudio,
  libsecret,
  alsa-lib,
  libXScrnSaver,
  glib,
  pango,
  cairo,
  gdk-pixbuf,
  fontconfig,
  freetype,
  dbus,
  expat,
  libpng,
  libtiff,
  libjpeg,
  zlib,
  cups,
  libX11,
  libXext,
  libXrandr,
  libXinerama,
  libXi,
  libXcursor,
  libXcomposite,
  libXdamage,
  libXfixes,
  ffmpeg-full,
}:

stdenv.mkDerivation rec {
  pname = "roam";
  version = "196.0.0-beta001";

  src = fetchurl {
    url = "https://download.ro.am/Roam/8a86d88cfc9da3551063102e9a4e2a83/linux/debian/binary/${version}-roam_${version}_amd64.deb";
    sha256 = "085d6f2a0ph4ip2yc8wmv4k1x6bshswlflrwkyj87p8mipy6d4a3";
  };

  nativeBuildInputs = [
    makeWrapper
    autoPatchelfHook
  ];
  buildInputs = [
    gtk3
    libappindicator-gtk3
    nss
    nspr
    xdg-utils
    libgbm
    libsecret
    alsa-lib
    libXScrnSaver
    pulseaudio
    glib
  ];

  unpackPhase = ''
    ar x $src
    tar -xf data.tar.xz
  '';

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/lib
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons
    mkdir -p $out/share/doc

    # Copy binary and libraries
    cp -r usr/lib/roam $out/lib/
    cp -r usr/share/* $out/share/

    # Create wrapper for binary
    makeWrapper $out/lib/roam/Roam $out/bin/roam

    # Copy documentation
    cp -r usr/share/doc/roam $out/share/doc/

    # Fix permissions
    chmod +x $out/lib/roam/Roam
    chmod +x $out/lib/roam/chrome_crashpad_handler
    chmod +x $out/lib/roam/chrome-sandbox

    # Auto patch ELF binaries (ignore missing ffmpeg for now)
    autoPatchelf $out/lib/roam/Roam --ignore-missing="libffmpeg.so"

    # Wrap the binary with proper environment variables
    makeWrapper $out/lib/roam/Roam $out/bin/roam \
      --prefix LD_LIBRARY_PATH : ${
        lib.makeLibraryPath [
          gtk3
          libappindicator-gtk3
          nss
          nspr
          xdg-utils
          libsecret
          libXScrnSaver
          pulseaudio
          glib
          libgbm
          alsa-lib
          stdenv.cc.cc
        ]
      } \
      --prefix XDG_DATA_DIRS : "${gtk3}/share/gsettings-schemas/${gtk3.name}:" \
      --set GIO_EXTRA_MODULES "${glib.out}/lib/gio/modules"
  '';

  meta = with lib; {
    description = "Roam: AI-Powered Virtual HQ";
    longDescription = ''
      Roam is an immersive platform that gives remote companies their own virtual HQ 
      for their colleagues, guests, customers, and professional network. It's an 
      entire office building that you can customize for the specific composition of 
      your company or team, consisting of individual offices, conference rooms, team 
      rooms, theaters and more. Roam freely within your Roam. Remote office buildings 
      exist in a broader Roamverse, where users can visit other Roams as well.
    '';
    homepage = "https://ro.am";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    maintainers = with maintainers; [ ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
  };
}
