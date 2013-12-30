#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      module Attribute
        class Vlan
          attr_accessor :identifier, :macs

          def initialize(identifier)
            @identifier = identifier
          end

          def add(mac)
            @macs.push mac
          end
        end
      end
    end
  end
end
