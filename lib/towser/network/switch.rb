#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      attr_accessor :config
      attr_accessor :bridge_table

      def load_switch_config(config)
        @config = Towser::Network::Switch::Config.new(config)
      end

      def load_bridge_table(config)
        @bridge_table = Towser::Network::Switch::Bridge::Table.new(config)
      end

      # combine switch config and bridge_table data
      def combine_data
        @config.ethernet_interfaces.each do |identifier, interface|
          if defined?(interface.switchport.added)

            vlans = @bridge_table.find_macs_for_port(interface.stack_member, interface.unit, interface.port)

            next if vlans.nil?

            interface.switchport.added.vlans.each do |vlan, data|
              next if data.nil?
              next if vlans[vlan].nil?
              data.macs = vlans[vlan].macs
            end
          end
        end
      end

      def find_port(mac)
      end

      def to_hash
        {
          :config => config.to_hash,
          :bridge_table => bridge_table.to_hash,
        }
      end

      alias_method :inspect, :to_hash
      alias_method :to_s, :to_hash
    end
  end
end
