#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      module Attribute
        class Vlans
          attr_accessor :vlans

          def initialize(data)
            objectify(data)
          end

          def objectify(data)
            return if data.nil?
            @vlans ||= []
            data.each do |vlan|
              @vlans.push Switch::Attribute::Vlan.new(vlan)
            end
          end

          def [](n)
            @vlans[n]
          end

          def each
            @vlans.each { |vlan| yield vlan }
          end
        end
      end
    end
  end
end
