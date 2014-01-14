{#
File States Examples
http://salt.readthedocs.org/en/latest/ref/states/all/salt.states.file.html
#}


{#
Create a directory (/opt/example).
#}
/opt/example:
  file.directory


{#
Create a directory with defined permissions.
#}
/opt/example/projects:
  file.directory:
    - user: vagrant
    - group: admin
    - mode: 755


{#
Create a list of directories.
Note the name is different.
#}

example_dirs:
  file.directory:
    - names:
      - /etc/example
      - /var/log/example


{#
Create a directory (/opt/example/code/project1).
Create any folders below which do not already exist (/opt/example/code).
#}

/opt/example/code/project1:
  file.directory:
    - makedirs: True


{#
Create a symlink (/opt/example/live).
Require target directory to already exist (/opt/example/code/project1).
#}

/opt/example/live:
  file.symlink:
    - target:  /opt/example/code/project1
    - require:
      - file: /opt/example/code/project1


{#
Create a file (/opt/example/code/project1/mycode.txt) with defined permissions.
Manage the contents of the file (Hello World!).
Require target directory to already exist (/opt/example/code/project1/) and symlink (/opt/example/live).
#}

/opt/example/code/project1/mycode.txt:
  file.managed:
    - user: vagrant
    - contents: |
        Hello World!
    - require:
      - file: /opt/example/code/project1
      - file: /opt/example/live


{#
Create a file (/opt/example/code/project1/myfile.txt) with defined permissions.
Manage the contents of the new file from a source file (salt://example/files/myfile.txt).
#}

/opt/example/code/project1/myfile.txt:
  file.managed:
    - source: salt://example/files/myfile.txt
    - mode: 644
    - require:
      - file: /opt/example/code/project1


{#
Create a file (/opt/example/code/project1/mytemplate.txt) with defined permissions.
Manage the contents of the new file from a template file (salt://example/templates/mytemplate.txt).
Set a default variable in the template.
#}

/opt/example/code/project1/mytemplate.txt:
  file.managed:
    - source: salt://example/templates/mytemplate.txt
    - mode: 644
    - template: jinja
    - defaults:
        planet: "Earth"
    - require:
      - file: /opt/example/code/project1

