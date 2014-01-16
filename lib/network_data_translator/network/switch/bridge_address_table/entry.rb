#!/usr/bin/env ruby

module NetworkDataTranslator
  class Network
    class Switch
      class BridgeAddressTable
        class Entry
          attr_reader :identifier, :port, :unit, :stack_member, :vlans

          def initialize(identifier, entry)
            @identifier    = identifier
            @port          = entry[:port].to_i
            @unit          = entry[:unit]
            @stack_member  = entry[:stack_member].to_i
            @vlans         = NetworkDataTranslator::Network::Switch::Attribute::Vlans.new(entry[:vlans]) unless entry[:vlans].nil?
          end
        end
      end
    end
  end
end
