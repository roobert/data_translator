#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))

require 'switch_config_parser'
require 'towser'
require 'awesome_print'
require 'yaml'

DATA_DIR = File.join(File.dirname(__FILE__), '../data')

# network consists of machines and switches
# network = Network.new
# view of switches:
# * see which machine interfaces are visible on which ports
# machines view:
# * see which switches each interface is plugged into

# TODO: add snmp data parser..
switch_config = SwitchConfigParser::Regexp::Config.parse(IO.readlines(File.join(DATA_DIR, "switch.config")))
bridge_table  = SwitchConfigParser::Regexp::BridgeTable.parse(IO.readlines(File.join(DATA_DIR, "bridge_table.config")))

# machine config is already a hash so need to run through a parser first, although we could do with improving mcollective plugin to output proper json / yaml..
#machines = Machines.new(YAML.load_file('../data/mcollective.config'))

#machines.find_machine('d4bed9fbbb65')

switch = Towser::Network::Switch.new
switch.load_switch_config(switch_config)
switch.load_bridge_table(bridge_table)

#switch.load_machines(machines)
switch.combine_data
ap switch.config.to_hash

#machines.combine_data(switch)

