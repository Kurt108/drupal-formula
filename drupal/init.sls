{% from "drupal/map.jinja" import drupal with context %}

# can have more option s(like source, pear, ..) but is installed as a base

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








