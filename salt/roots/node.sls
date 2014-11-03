git_packages:
  pkg.installed:
    - names:
      - libssl-dev
      - git
      - pkg-config
      - build-essential
      - curl
      - gcc
      - g++
      - checkinstall

## Get Node
get-node:
  file.managed:
    - name: /usr/src/node-v0.10.28.tar.gz
    - source: http://nodejs.org/dist/v0.10.28/node-v0.10.28.tar.gz
    - source_hash: sha1=ef08a75f6359a16e672cae684e0804ca7f4554b7
    - require:
      - pkg: git_packages
  cmd.wait:
    - cwd: /usr/src
    - names:
      - tar -zxvf node-v0.10.28.tar.gz
    - watch:
      - file: /usr/src/node-v0.10.28.tar.gz

make-node:
  cmd.wait:
    - cwd: /usr/src/node-v0.10.28
    - names:
      - ./configure
      - make --jobs=1
      - checkinstall --install=yes --pkgname=nodejs --pkgversion "0.10.28" --default
    - watch:
      - cmd: get-node
