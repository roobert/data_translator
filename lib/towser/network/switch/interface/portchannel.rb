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
        end
      end
    end
  end
end
