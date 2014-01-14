example-formula
============

Framework for VirtualBox/Vagrant/SaltStack

Requirements:

* Virtual Box: https://www.virtualbox.org/wiki/Downloads
* Vagrant: http://www.vagrantup.com/

Startup your VM
---------------

```
cd <where you downloaded or cloned this repo>
vagrant up
vagrant ssh
```

Default superuser credentials
-----------------------------
```
username: vagrant
password: vagrant
```

What's a State?
===============

*  A state is a piece of code that ensures that the minion is in a known form.
* It will either: perform actions to achieve this (blue), confirm that the minion
already has this form (green), or alert if it cannot be set (red).
* States may be dependant or other states, or only run under certain conditions.
* States can be logically separated into separate "sls" documents, which can be run individually
* The group of states should always return green when run a second time, to confirm nothing 
has changed.

Examples: 
* Install package
* Create user
* Run a command, unless another command executes successfully
* Create a file from a template


What's a Module?
===============

* A command-line method of executing commands on minions usings the salt framework
* Modules are used by salt when enforcing salt states
* Alternative to SSH'ing into minions

Examples:
* Restart a service
* Check if a file exists
* Run a state manually


What's a Pillar?
================

* A pillar is a variable that can change how a state is run.
* There should be pillar defaults set in the state documents so that a state can be run without
the need for a pillar document.
* A pillar "sls" document can be created to override some or all of the defaults.
* Pillars can be shared between multiple minions

Examples:
* Set a the version of an application to be installed
* Set a password to be used in a template configuration file
* Set the desired size of a volume

What's a Formula?
============

Formulas are self contained salt projects under version control designed to install and configure a
specific role (eg, Zonza webserver, PSQL server with a blank database and user).
They have a standard framework of supporting files:

```
example-formula        -- The project
|-- example/           -- The "example" state folder, named after the formula
|   |-- init.sls    -- The "example" state
|-- Vagrantfile     -- The description of the virtual machine
|-- minion          -- Salt minion configuration defaults
|-- top.sls         -- List of states to apply to the virtual machine
|-- pillar.example  -- All pillar options with the default values
|-- README.md       -- This file
`-- CHANGELOG.md
```

The intention is that any user can checkout the formula and start a virtual machine
to begin testing an application.

The states within the formula should be able to be used as submodules on a Salt master
to be combined with other formulas.

States should have pillars for variable values (eg application version), however there
should be a sane set of defaults so that the application is functional.



Example Salt States
============

By default, your VM will include the states in  ```example-formula/example/init.sls```

In addition, there are runnable examples in various other files within the example folder which have
to be called individually.

For example, to try the states in ```example-formula/example/pkg.sls``` within your VM, run:

```
sudo salt-call state.sls example.pkg
```



Creating Salt States
============

Edit the file ```example-formula/example/mytest.sls``` with the changes you would like to test.

Set your editor to use YAML highlighting for .sls files.


Testing Your Salt States
============

You do not need to reprovision your VM in order to test your state file.
You can easily target a particular file that contains your changes.

Assuming changes in ```example-formula/example/mytest.sls```, just run:

```
sudo salt-call state.sls example.mytest
```

Try to running fewer states at once to help debug issues.  Once you are happy with them, then combine with 
the other tested states to ensure your formula runs from a fresh install with the correct dependancies.


Running Multiple Salt States (Highstate)
============

Add all of the sls files that you want to include in the ```example-formula/top.sls```.
By default the contents of ```example-formula/example/mytest.sls``` are included.

Either run ```vagrant provision``` from the host OS, or ```sudo salt-call state.highstate```
from within the guest OS (virtual machine).  This will run all of the states in the ```top.sls```


References
============

States: http://docs.saltstack.com/ref/states/all/

Pillars: http://docs.saltstack.com/topics/tutorials/pillar.html

Formulas: http://docs.saltstack.com/topics/conventions/formulas.html

Vagrant: http://docs.vagrantup.com/v2/
