#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      module Interface
        module Attribute
          class Switchport
            attr_reader :mode, :added, :removed, :acceptable_frame_type

            def initialize(switchport)
              objectify(switchport)
            end

            def objectify(switchport)
              @mode                  = switchport[:mode]
              @acceptable_frame_type = switchport[:acceptable_frame_type]

              return if switchport[:vlans].nil?

              @added   = Towser::Network::Switch::Attribute::Vlans.new(switchport[:vlans][:add]) unless switchport[:vlans][:add].nil?
              @removed = Towser::Network::Switch::Attribute::Vlans.new(switchport[:vlans][:remove]) unless switchport[:vlans][:remove].nil?
            end
          end
        end
      end
    end
  end
end
