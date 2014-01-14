{#
Basic examples.  See supporting sls files for more examples.
http://salt.readthedocs.org/en/latest/ref/states/all/
#}

salt-minion:
  pkg:
    - installed

/etc/salt:
  file:
    - directory

salt_minion_service:
  service.running:
    - name: salt-minion
