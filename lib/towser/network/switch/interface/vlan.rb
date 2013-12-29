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

          def to_hash
            {
              :identifier  => identifier,
              :description => description,
              :vlan        => vlan
            }
          end

          alias_method :inspect, :to_hash
          alias_method :to_s, :to_hash
        end
      end
    end
  end
end
