add-key:
  cmd.run:
    - name: sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7

/etc/apt/sources.list.d/passenger.list:
  file.managed:
    - source: salt://passenger/passenger.list
    - require_in:
      - pkg: make-passenger
    - require:
      - cmd: add-key

passenger-dependencies:
  pkg.installed:
    - names:
      - apt-transport-https
      - ca-certificates

make-passenger:
  pkg.installed:
    - names:
      - nginx-extras
      - passenger
    - refresh: true
    - require:
      - cmd: run-ruby

run-update:
  cmd.run:
    - names:
      - sudo dpkg --configure -a
      - sudo apt-get update

run-rvm:
  cmd.run:
    - names:
      - sudo gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
      - \curl -sSL https://get.rvm.io | bash
      - source /etc/profile.d/rvm.sh
      - source ~/.bashrc
    - require:
      - cmd: run-update

run-ruby:
  cmd.run:
    - names:
      - sudo rvm install ruby-2.1.5
      - rvm use ruby-2.1.5
    - require:
      - cmd: run-rvm