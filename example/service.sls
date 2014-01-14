{#
Service States Examples
http://salt.readthedocs.org/en/latest/ref/states/all/salt.states.service.html
#}


{#
Ensures a service is running (ssh).
#}

ssh:
  service:
    - running


{#
Combine states to install a package
and ensure the service is running (ntp).
#}

ntp:
  pkg:
    - installed
  service:
    - running


{#
Combine states to install a package before
ensuring the service is running (apparmor).
#}

apparmor:
  pkg:
    - installed
  service.running:
    - require:
      - pkg: apparmor


{#
Installs package and dependancies (nginx).
Removes default configuration file after installing all packages (/etc/nginx/sites-enabled/default).
Starts the service (nginx) after installing all packages.
Reload the service if there are any changes to states that match the pattern (file: /etc/nginx/sites-enabled/*).
#}

nginx:
  pkg.installed:
    - pkgs:
      - nginx
      - nginx-full
      - libxslt1.1
      - libjpeg-turbo8
      - libgd2-noxpm
      - libjpeg8
  file.absent:
    - name: /etc/nginx/sites-enabled/default
    - require:
      - pkg: nginx
  service.running:
    - require:
      - pkg: nginx
    - watch:
      - file: /etc/nginx/sites-enabled/*
    - reload: True

