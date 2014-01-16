#!/usr/bin/env ruby

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '../lib'))

require 'switch_data_parser'
require 'network_data_translator'
require 'awesome_print'
require 'yaml'

include NetworkDataTranslator

DATA_DIR         = File.join(File.dirname(__FILE__), '../data')
CONFIG_DIR       = File.join(DATA_DIR, 'config')
BRIDGE_TABLE_DIR = File.join(DATA_DIR, 'bridge_address_table')

switches = ARGV
machine_config = YAML.load_file(File.join(DATA_DIR, 'network_interfaces.txt'))

network = Network.new('bunker')

network.add_switches(switches)

switches.each do |switch|
  switch_config        = SwitchDataParser::Regexp::Config.parse(IO.readlines(File.join(CONFIG_DIR, switch)))
  bridge_address_table = SwitchDataParser::Regexp::BridgeAddressTable.parse(IO.readlines(File.join(BRIDGE_TABLE_DIR, switch)))

  network.switches.each do |s|
    if s.identifier == switch
      s.load_switch_config(switch_config)
      s.load_bridge_address_table(bridge_address_table)
    end
  end
end

network.add_machines(machine_config)

# this is probably an awful thing to do..
#network.associate_machine_interfaces_with_switch_ports
#network.associate_switch_port_mac_addresses_with_machine_interfaces

#puts network.switches[0].config.ethernet_interfaces.to_yaml
puts network.to_yaml

#      def combine_data
#        @config.ethernet_interfaces.each do |interface|
#          if defined?(interface.switchport.added)
#
#            bridge_vlan_data = @bridge_address_table.find_macs_for_port(interface.stack_member, interface.unit, interface.port)
#
#            next if bridge_vlan_data.nil?
#
#            # probably much better way to do this would be to merge the bridge vlan config with the switch interface and then raise errors
#            # on any vlans that have no macs or any vlans that exist in the bridge table but not on the interface..
#
#            interface.switchport.added.vlans.each do |vlan|
#              bridge_vlan_data.each do |bridge_vlan|
#                if bridge_vlan.identifier = vlan.identifier
#                  vlan.macs = bridge_vlan.macs
#                end
#              end
#            end
#          end
#        end
#      end
