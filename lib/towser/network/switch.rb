#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      attr_accessor :identifier, :config, :bridge_address_table

      def initialize(identifier)
        @identifier = identifier
      end

      def load_switch_config(config)
        @config = Towser::Network::Switch::Config.new(config)
      end

      def load_bridge_address_table(config)
        @bridge_address_table = Towser::Network::Switch::BridgeAddressTable.new(config)
      end

#<Towser::Network::Switch::Attribute::Vlan:0x000000023ecba8 @identifier=306, @macs=[]>
#[
#    [0] #<Towser::Network::Switch::Attribute::Vlan:0x000000023b59f0 @identifier=306, @macs=[{:mac=>"001D.7032.469A", :mode=>"Dynamic"}]>,
#    [1] #<Towser::Network::Switch::Attribute::Vlan:0x000000023b5720 @identifier=311, @macs=[{:mac=>"001D.7032.469A", :mode=>"Dynamic"}]>
#]

      def combine_data
        @config.ethernet_interfaces.each do |interface|
          if defined?(interface.switchport.added)

            bridge_vlan_data = @bridge_address_table.find_macs_for_port(interface.stack_member, interface.unit, interface.port)

            next if bridge_vlan_data.nil?

            # probably much better way to do this would be to merge the bridge vlan config with the switch interface and then raise errors
            # on any vlans that have no macs or any vlans that exist in the bridge table but not on the interface..

            interface.switchport.added.vlans.each do |vlan|
              bridge_vlan_data.each do |bridge_vlan|
                if bridge_vlan.identifier = vlan.identifier
                  vlan.macs = bridge_vlan.macs
                end
              end
            end
          end
        end
      end
    end
  end
end
