{ stdenv, fetchgit, qt4, qmake4Hook, subversion, apr }:

stdenv.mkDerivation rec {
  name = "svn2git-kde-1.0.5";

  src = fetchgit {
    url = http://git.gitorious.org/svn2git/svn2git.git;
    rev = "149d6c6e14a1724c96999328683a9264fc508264";
    sha256 = "0gjxhnraizlwyidn66rczwc01f6sfx4ndmsj86ssqml3p0d4sl6q";
  };

  NIX_CFLAGS_COMPILE = [ "-I${apr.dev}/include/apr-1" "-I${subversion.dev}/include/subversion-1" "-DVER=\"${src.rev}\"" ];

  patchPhase = ''
    sed -i 's|/bin/cat|cat|' ./src/repository.cpp
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp svn-all-fast-export $out/bin
  '';

  buildInputs = [ subversion apr qt4 ];

  nativeBuildInputs = [ qmake4Hook ];

  meta.broken = true;
}
