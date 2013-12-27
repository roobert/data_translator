#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      module Attribute
        class Vlan
          attr_accessor :vlan, :macs

          def initialize(vlan, macs)
            @vlan = vlan.to_i
            @macs = macs
          end

          def to_hash
            {
              :vlan => vlan,
              :macs => macs.to_hash,
            }
          end

          alias_method :inspect, :to_hash
          alias_method :to_s, :to_hash
        end
      end
    end
  end
end
