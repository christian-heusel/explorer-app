Ansible Role Backend
=========

Diese Rolle setzt das Backend auf einem Raspberry mit Raspbian auf.

Requirements
------------

Any pre-requisites that may not be covered by Ansible itself or the role should be mentioned here. For instance, if the role uses the EC2 module, it may be a good idea to mention in this section that the boto package is required.

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------
Man kann die Dependencies für diese Rolle über den folgenden Befehl installieren:

```
ansible-galaxy install -r requirements.yml
```

Zusätzlich wird erwartet, dass die Collection `community.general` installiert ist:

```
ansible-galaxy collection install community.general
```

License
-------

BSD

Author Information
------------------

Christian Heusel  
E-Mail: christian@heusel.eu  
Website: https://christian.heusel.eu
