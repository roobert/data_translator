#!/usr/bin/env ruby

module Towser
  class Network
    class Switches
      attr_reader :switches

      def initialize
        @switches = {}
      end

      def add(hosts)
        hosts.each do |host|
          switch_config = SwitchDataParser::Regexp::Config.parse(File.read(File.join(CONFIG_DIR, host)))
          bridge_table  = SwitchDataParser::Regexp::BridgeAddressTable.parse(File.read(File.join(BRIDGE_TABLE_DIR, host)))
          current_switch = Towser::Network::Switch.new
          current_switch.load_switch_config(switch_config)
          current_switch.load_bridge_table(bridge_table)
          current_switch.combine_data

          @switches[host] = current_switch
        end
      end
    end
  end
end
