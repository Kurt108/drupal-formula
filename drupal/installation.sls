{% from "drupal/map.jinja" import drupal with context %}

include:
  - drupal
  - drupal.{{ drupal.database }}



drupal-download-via-drush:
  cmd.run:
    - name: drush dl --quiet drupal-{{ drupal.version }}
    - cwd: {{ drupal.doc_root }}
    - creates: {{ drupal.doc_root  }}/drupal-{{ drupal.version }}/index.php
    - user: {{ drupal.user }}
    - require_in:
      - cmd: drupal-site-install-via-drush


settings:
  file.managed:
    - name: {{ drupal.doc_root  }}/drupal-{{ drupal.version }}/sites/default/settings.php
    - source: salt://drupal/files/settings.php
    - template: jinja
    - user: {{ drupal.user }}
    - group: {{ drupal.user }}
    - context:
        drupal: {{ drupal }}
    - require:
      - sls: drupal.{{ drupal.database }}

drupal-files-dir:
  file.directory:
    - name: {{ drupal.doc_root }}/drupal-{{ drupal.version }}/sites/default/files
    - user: {{ drupal.user }}
    - group: {{ drupal.user }}


drupal-sites-default-private-dir:
  file.directory:
    - name: {{ drupal.doc_root }}/drupal-{{ drupal.version }}/sites/default/private
    - user: {{ drupal.user }}
    - group: {{ drupal.user }}


