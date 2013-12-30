* add snmp data parser
* improve mcollective rpc plugin
* work out a better way to pass in data to network
* add some kinds of settings object ala sinatra
* padrino for dashboards
* change mac address stuff for the switch to be { :mode => mode, :machine_interface = machine... }
* make sure multiple port assignment per interface is working properly..
* use arrays not hashes and make sure each object has its own identifier included

* make switchport lines individual objects..

* decide whether to write object model to database

* commit object module as seperate project?

* create 'views' of data in object model..

* mac addresses sometimes quoted?

Towser = model of the data (backend)
blah = frontend, views of the data.. e.g: load the data model into memory and then create helpers to do lookups on the data set to resolve stuff, etc.
