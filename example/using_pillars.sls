{#
Using Pillars in States Examples
http://salt.readthedocs.org/en/latest/topics/pillar/index.html

All variables are set once at the top of the sls.  In this example the vars are kept
with the states for readability.
Salt will execute the pillar.get command when evaluating the jinja template.
This will reference any information stored in /srv/pillar/top.sls.

If the pillar.get command fails (i.e. no data returned) it will use the default value supplied
Typically, formulas do not have /srv/pillar/top.sls therefore rely on a set of sane defaults.
#}


{#
Install a package from the pillar 'mypkg', if not default to 'vim'
Example alternative pillar ::
  mypkg: nano

#}

{% set mypkg = salt['pillar.get']('mypkg', 'vim') %}

{{ mypkg }}:
  pkg:
    - installed


{#
Install the defined version of curl, if not default to '7.22.0-3ubuntu4.6'
Example alternative pillar ::
  curl:
    version: '8.22.0-3ubuntu4.7'

#}

{% set curl_version = salt['pillar.get']('curl:version', '7.22.0-3ubuntu4.6') %}

curl:
  pkg.installed:
    - version: {{ curl_version }}


{#
Creates a file with the contents taken from a dictionary.
Example alternative pillar ::
  mycontents:
    planet: 'Mars'
    name: 'Simon'

#}

{% set text = salt['pillar.get']('mycontents', {'planet': 'Earth', 'name': 'Alex'}) %}

/opt/mypillars.txt:
  file.managed:
    - user: vagrant
    - contents: |
        Hello {{ text.planet }}!
        My Name is {{ text.name }}!
