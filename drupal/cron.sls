{% from "drupal/map.jinja" import drupal with context %}

include:
  - drupal



drush --root={{ drupal.doc_root }}/drupal-{{ drupal.version }} --uri={{ salt['grains.get']('fqdn') }} --quiet cron:
  cron.present:
    - identifier: drupal-crontask
    - user: {{ drupal.user }}
    - minute: 10
    - hour: '*'


cron-path-environment-{{ drupal.user }}:
  cron.env_present:
    - name:  PATH
    - value: '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
    - user: {{ drupal.user }}