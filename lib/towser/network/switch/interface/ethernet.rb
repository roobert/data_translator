#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      module Interface
        class Ethernet
          attr_accessor :description, :stack_member, :port, :unit, :switchport

          def initialize(identifier, interface)
            @identifier   = identifier
            @description  = interface[:description]
            @stack_member = interface[:stack_member].to_i
            @port         = interface[:port].to_i
            @unit         = interface[:unit]
            @switchport   = Towser::Network::Switch::Interface::Attribute::Switchport.new(interface[:switchport]) unless interface[:switchport].nil?
          end

          def to_hash
            {
              :identifier   => @identifier,
              :description  => @description,
              :stack_member => @stack_member,
              :port         => @port,
              :unit         => @unit,
              :switchport   => @switchport,
            }
          end

          alias_method :inspect, :to_hash
          alias_method :to_s, :to_hash
        end
      end
    end
  end
end
