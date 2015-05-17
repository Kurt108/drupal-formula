{% from "drupal/map.jinja" import drupal with context %}

include:
  - drupal



sqlite3:
  pkg.installed

#TODO php5-packeags will later be managed by own formula

php5-sqlite:
  pkg.installed

# TODO php.ini needs an option sendmail_path = /bin/true

php5-gd:
  pkg.installed


drupal-site-install-via-drush:
  cmd.run:
    - name: drush si -y --db-url=sqlite://{{ drupal.db_name }}.sqlite ; exit 0
    - cwd: {{ drupal.doc_root  }}/drupal-{{ drupal.version }}
    - creates: {{ drupal.doc_root  }}/drupal-{{ drupal.version }}/{{drupal.db_name }}.sqlite
    - user: {{ drupal.user }}


