{% from "drupal/map.jinja" import drupal with context %}

include:
  - drupal


{% for modul in drupal.modules %}
{{ modul }}:
  cmd.run:
    - name: drush en --quiet {{ modul }} -y && touch {{ drupal.doc_root }}/drupal-{{ drupal.version }}/sites/all/module-installed-{{ modul }}
    - cwd: {{ drupal.doc_root }}/drupal-{{ drupal.version }}
    - creates: {{ drupal.doc_root }}/drupal-{{ drupal.version }}/sites/all/module-installed-{{ modul }}
    - user: {{ drupal.user }}
    - watch_in:
      - cmd: drupal-clear-cache
      - cmd: drupal-updatedb
      - cmd: drupal-truncate-user
{% endfor %}
