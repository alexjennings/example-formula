{#
Package States Examples
http://salt.readthedocs.org/en/latest/ref/states/all/salt.states.pkg.html
#}


{#
Installs a single package (git).
#}

git:
  pkg:
    - installed


{#
Installs a single package (vim).

Note the name of the state is not
the same as the package to be installed.
This can avoid conflicts when combining states.
#}

install_vim_package:
  pkg.installed:
    - name: vim


{#
Installs a single package (telnet).
The version is pinned (0.17-36build1)
#}

telnet:
  pkg.installed:
    - version: 0.17-36build1


{#
Installs a list of curl packages (curl, libcurl3, curl-ssl).

The name of the state is not relative to the
packages that are installed.

Using 'pkgs' will install multiple packages a single state.  This is advised
over using 'names' which will create a state for each package in the list.
#}

install_list_packages:
  pkg.installed:
    - pkgs:
      - curl
      - libcurl3
      - curl-ssl


{#
Add a custom package repository (chris-lea/node.js).
Require repository before installing package (nodejs)
#}

nodejs:
  pkgrepo.managed:
    - ppa: chris-lea/node.js
    - require_in:
      - pkg: nodejs
  pkg:
    - latest
