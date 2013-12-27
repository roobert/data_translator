#!/usr/bin/env ruby

module Towser
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
            @vlans         = Towser::Network::Switch::Attribute::Vlans.new(entry[:vlans]) unless entry[:vlans].nil?
          end
        end

        def to_hash
          {
            :identifier => identifier,
            :vlans => vlans,
          }
        end

        alias_method :inspect, :to_hash
        alias_method :to_s, :to_hash
      end
    end
  end
end
