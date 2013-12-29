#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      module Attribute
        class Vlans
          attr_accessor :vlans

          def initialize(vlans)
            @vlans = {}

            vlans.each do |vlan, macs|
              @vlans[vlan.to_i] = Switch::Attribute::Vlan.new(vlan, macs)
            end
          end

          def each
            @vlans.each { |vlan,macs| yield vlan, macs }
          end

          def to_hash
            {
              :vlans => vlans.to_hash
            }
          end

          alias_method :inspect, :to_hash
          alias_method :to_s, :to_hash
        end
      end
    end
  end
end
