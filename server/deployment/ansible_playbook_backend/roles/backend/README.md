Ansible Role Backend
=========

Diese Rolle setzt das Backend auf einem Raspberry mit Raspbian auf.
Genauers:

1. erstellt sie ein Projektverzeichnis
2. klont das Projekt von GitHub
3. Baut und startet das docker image
4. Setzt einen Apache2 Vhost mit ReverseProxy auf

Requirements
------------
None

Role Variables
--------------

A description of the settable variables for this role should go here, including any variables that are in defaults/main.yml, vars/main.yml, and any variables that can/should be set via parameters to the role. Any variables that are read from other roles and/or the global scope (ie. hostvars, group vars, etc.) should be mentioned here as well.

Dependencies
------------
Es wird erwartet, dass die Collection `community.general` installiert ist:

```
ansible-galaxy collection install community.general
```

License
-------

GPL-3

Author Information
------------------

Christian Heusel  
E-Mail: christian@heusel.eu  
Website: https://christian.heusel.eu
