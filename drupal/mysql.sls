{% from "drupal/map.jinja" import drupal with context %}

include:
  - drupal



#TODO php5-packeags will later be managed by own formula

php5-mysql:
  pkg.installed

# TODO php.ini needs an option sendmail_path = /bin/true



drupal-site-install-via-drush:
  cmd.run:
    - name: drush si -y --db-url=sqlite://{{ drupal.db_name }}.sqlite ; exit 0
    - cwd: {{ drupal.doc_root  }}/drupal-{{ drupal.version }}
    - only_if:
      - cmd: drush status | grep Database | grep Connected
    - user: {{ drupal.user }}

