#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      module Interface
        class Vlan
          attr_reader :identifier, :vlan, :description

          def initialize(identifier, interface)
            @identifier  = identifier
            @vlan        = interface[:vlan]
            @description = interface[:description]
          end
        end
      end
    end
  end
end
