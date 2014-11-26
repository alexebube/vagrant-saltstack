/etc/apt/nginx_signing.key:
  file.managed:
    - source: salt://nginx/nginx_signing.key
    - name: /etc/apt/nginx_signing.key
    - create: true
    - mode: 755
    - require_in:
      - pkg: nginx-key

nginx-key:
  cmd.run:
    - name: sudo apt-key add /etc/apt/nginx_signing.key

/etc/apt/sources.list:
  file.managed:
    - source: salt://nginx/nginx.list
    - require_in:
      - pkg: make-nginx

nginx-update:
  cmd.run:
    - names:
      - sudo dpkg --configure -a
      - sudo apt-get update

make-nginx:
  pkg.installed:
    - name: nginx
    - require:
      - cmd: nginx-update