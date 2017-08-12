{% if salt['pillar.get']('mongodb:mongodb_root_user', '') != '' and salt['pillar.get']('mongodb:mongodb_root_password', '') != '' and salt['pillar.get']('mongodb:mongodb_admin_user', '') != '' and salt['pillar.get']('mongodb:mongodb_admin_password', '') != '' %}

auth_config:
  file.managed:
    - name: /tmp/mongodb.auth_config
    - source: salt://mongodb/files/mongodb.auth_config
    - template: jinja
    - user: root
    - group: root
    - mode: 0600
    - context:
      root_user: {{ salt['pillar.get']('mongodb:root_user', '') }}
      root_password: {{ salt['pillar.get']('mongodb:root_password', '') }}
      admin_user: {{ salt['pillar.get']('mongodb:admin_user', '') }}
      admin_password: {{ salt['pillar.get']('mongodb:admin_password', '') }}

use_auth_config:
  cmd.run:
    - name: mongo < /tmp/mongodb.auth_config && rm -f /tmp/mongodb.auth_config

{% endif %}
