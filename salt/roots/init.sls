init-list:
  file.managed:
    - source: salt://init/sources.list
    - name: /etc/apt/sources.list

update:
  cmd.run:
    - names:
      - sudo apt-get update
    - require:
      - file: init-list