{% from "drupal/map.jinja" import drupal with context %}

include:
  - drupal
  - drupal.{{ drupal.database }}



{% for library in drupal.external_lib %}
{{ library }}:
  file.managed:
    - name: {{ drupal.doc_root }}/drupal-{{ drupal.version }}/sites/all/libraries/{{ library }}/{{ library }}.php
    - source: salt://drupal/files/{{ library }}.php
    - user: {{ drupal.user }}
    - group: {{ drupal.user }}
    - require:
      - sls: drupal.{{ drupal.database }}
    - makedirs: True
{% endfor %}

