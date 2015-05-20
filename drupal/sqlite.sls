{% from "drupal/map.jinja" import drupal with context %}

include:
  - drupal
  - php.ng.sqlite
  - php.ng.gd
  - php.ng.cli.ini



sqlite3:
  pkg.installed



drupal-site-install-via-drush-with-sqlite:
  cmd.run:
    - name: drush si -y --db-url=sqlite://{{ drupal.db_name }}.sqlite  --account-name=admin --account-pass=admin
    - cwd: {{ drupal.doc_root  }}/drupal-{{ drupal.version }}
    - creates: {{ drupal.doc_root  }}/drupal-{{ drupal.version }}/{{drupal.db_name }}.sqlite
    - user: {{ drupal.user }}
    - require:
      - sls: php.ng.sqlite
      - sls: php.ng.gd
      - pkg: sqlite3
      - sls: php.ng.cli.ini



