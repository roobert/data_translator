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
    end
  end
end
