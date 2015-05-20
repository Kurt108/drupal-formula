{% from "drupal/map.jinja" import drupal with context %}

include:
  - drupal
  - php.ng.mysql
  - php.ng.cli.ini
  - php.ng.gd
{%- if drupal.db_host == '127.0.0.1' or drupal.db_host == 'localhost' %}
  - mysql.server
  - mysql.python
  - mysql.user
  - mysql.database
{% endif %}




drupal-site-install-via-drush-with-mysql:
  cmd.run:
    - name: drush si -y --db-url=mysql://{{ drupal.db_user }}:{{ drupal.db_pass }}@{{ drupal.db_host }}/{{ drupal.db_name }} --account-name=admin --account-pass=admin
    - cwd: {{ drupal.doc_root  }}/drupal-{{ drupal.version }}
    - unless:
      - drush status | grep Database | grep Connected
    - user: {{ drupal.user }}
    - require:
      - sls: php.ng.mysql
      - sls: php.ng.cli.ini
      - sls: php.ng.gd
      {%- if drupal.db_host == '127.0.0.1' or drupal.db_host == 'localhost' %}
      - sls: mysql.server
      - sls: mysql.python
      - sls: mysql.user
      - sls: mysql.database
      {% endif %}



