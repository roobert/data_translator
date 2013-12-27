#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      module Interface
        class PortChannel
          attr_reader :identifier, :description, :channel, :switchport

          def initialize(identifier, interface)
            @identifier  = identifier
            @description = interface[:description]
            @channel     = interface[:channel]
            @switchport  = Towser::Network::Switch::Interface::Attribute::Switchport.new(interface[:switchport])
          end

          def to_hash
            {
              :identifier => identifier,
              :description => description,
              :channel => channel,
              :switchport => switchport.to_hash,
            }
          end

          alias_method :inspect, :to_hash
          alias_method :to_s, :to_hash
        end
      end
    end
  end
end
