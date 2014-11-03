/etc/apache2/sites-available/acadaslate.com:
  file:
    - managed
    - source: salt://apache/site.conf
    - require:
      - pkg: apache2

apache2:
  pkg:
    - installed
  service:
    - running
    - watch:
      - file: /etc/apache2/sites-available/acadaslate.com
      - cmd: a2ensite acadaslate.com
    - require:
      - pkg: apache2

a2ensite acadaslate.com:
  cmd.run:
    - onlyif: test -f /etc/apache2/sites-available/acadaslate.com
    - require:
      - pkg: apache2
      - file: /etc/apache2/sites-available/acadaslate.com

/var/www:
  file.symlink:
    - target: /vagrant/acadaslate.com/public
    - force: True