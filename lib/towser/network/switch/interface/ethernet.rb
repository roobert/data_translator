#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      module Interface
        class Ethernet
          attr_accessor :identifier, :description, :stack_member, :port, :unit, :switchports

          def initialize(identifier, interface)
            @identifier = identifier

            self.objectify(interface)
          end

          def objectify(interface)
            @description  = interface[:description]
            @stack_member = interface[:stack_member].to_i
            @port         = interface[:port].to_i
            @unit         = interface[:unit]
            @switchports  = Towser::Network::Switch::Interface::Attribute::Switchports.new(interface[:switchports]) unless interface[:switchports].nil?
          end
        end
      end
    end
  end
end
