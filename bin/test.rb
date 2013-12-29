#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))

require 'switch_data_parser'
require 'towser'
require 'awesome_print'
require 'yaml'

include Towser

DATA_DIR         = File.join(File.dirname(__FILE__), '../data')
CONFIG_DIR       = File.join(DATA_DIR, 'config')
BRIDGE_TABLE_DIR = File.join(DATA_DIR, 'bridge_address_table')

switches = ARGV
machine_config = YAML.load_file(File.join(DATA_DIR, 'network_interfaces.txt'))

network = Network.new

network.add_switches(switches)
network.add_machines(machine_config)

# this is probably an awful thing to do..
network.associate_machine_interfaces_with_switch_ports
network.associate_switch_port_mac_addresses_with_machine_interfaces

puts network.to_hash.to_yaml
