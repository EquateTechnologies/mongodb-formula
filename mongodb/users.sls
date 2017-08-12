mongodb-users-pymongo-check:
  pkg.installed:
    - name: python-pymongo

{% from "mongodb/map.jinja" import mdb with context %}
{% if 'users' in mdb %}
{% for name, account in mdb.users.items() if account.username is defined and account.password is defined %}
{{ name }}:
  mongodb_user.present:
  - name: {{ account.username }}
  - passwd: {{ account.password }}
  - database: {{ account.database }}
{% if 'mongodb_admin_user' in mdb and 'mongodb_admin_password' in mdb %}
  - user: {{ mdb.mongodb_admin_user }}
  - password: {{ mdb.mongodb_admin_password }}
{% endif %}
{% if 'roles' in account %}
  - roles:
{% for role in account.roles %}
    - {{ role }}
{% endfor %}
{% endif %}
{% endfor %}
{% endif %}
