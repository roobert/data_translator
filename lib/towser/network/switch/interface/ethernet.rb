#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      module Interface
        class Ethernet
          attr_accessor :identifier, :description, :stack_member, :port, :unit, :switchport

          def initialize(identifier, interface)
            @identifier = identifier

            self.objectify(interface)
          end

          def objectify(interface)
            @description  = interface[:description]
            @stack_member = interface[:stack_member].to_i
            @port         = interface[:port].to_i
            @unit         = interface[:unit]
            @switchport   = Towser::Network::Switch::Interface::Attribute::Switchport.new(interface[:switchport]) unless interface[:switchport].nil?
          end
        end
      end
    end
  end
end
