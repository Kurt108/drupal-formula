{% from "drupal/map.jinja" import drupal with context %}

include:
  - nginx.ng.service


extend:
  nginx_service:
    service:
      - watch:
        - file: drupal-vhost-config
      - require:
        - file: drupal-vhost-config






# might have more options to install (like source, pear, ..)
drush:
  pkg.installed

{{ drupal.doc_root }}:
  file.directory:
    - name: {{ drupal.doc_root }}
    - user: {{ drupal.user }}
    - group: {{ drupal.user }}
    - makedirs: True


drupal-updatedb:
  cmd.wait:
    - name: drush updatedb -y
    - cwd: {{ drupal.doc_root }}/drupal-{{ drupal.version }}
    - user: {{ drupal.user }}
    - require:
      - pkg: drush

drupal-clear-cache:
  cmd.wait:
    - name: drush cc --quiet all
    - cwd: {{ drupal.doc_root }}/drupal-{{ drupal.version }}
    - user: {{ drupal.user }}
    - require:
      - pkg: drush

drupal-truncate-user:
  cmd.wait:
    - name: drush sqlq --quiet "TRUNCATE sessions"
    - user: {{ drupal.user }}
    - cwd: {{ drupal.doc_root }}/drupal-{{ drupal.version }}
    - require:
      - pkg: drush



drupal-vhost-config:
  file.managed:
    - name: /etc/nginx/conf.d/drupal
    - source: salt://drupal/files/nginx-config.conf
    - template: jinja
    - context:
        drupal: {{ drupal }}





