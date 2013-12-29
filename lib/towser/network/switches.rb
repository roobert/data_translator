#!/usr/bin/env ruby

module Towser
  class Network
    class Switches
      attr_reader :switches

      def initialize
        @switches = []
      end

      def [](n)
        @switches[n]
      end

      def each
        @switches.each { |switch| yield switch }
      end

      def add(hosts)
        hosts.each do |host|
          switch_config = SwitchDataParser::Regexp::Config.parse(IO.readlines(File.join(CONFIG_DIR, host)))
          bridge_address_table = SwitchDataParser::Regexp::BridgeAddressTable.parse(IO.readlines(File.join(BRIDGE_TABLE_DIR, host)))
          current_switch = Towser::Network::Switch.new(host)
          current_switch.load_switch_config(switch_config)
          current_switch.load_bridge_address_table(bridge_address_table)
          current_switch.combine_data

          @switches.push current_switch
        end
      end
    end
  end
end
