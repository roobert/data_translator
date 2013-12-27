#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      module Interface
        module Attribute
          class Switchport
            attr_reader :mode, :added, :removed, :acceptable_frame_type

            def initialize(switchport)
              @mode    = switchport[:mode]
              unless switchport[:vlans].nil?
                unless switchport[:vlans][:add].nil?
                  @added = Towser::Network::Switch::Attribute::Vlans.new(switchport[:vlans][:add])
                end
                unless switchport[:vlans][:remove].nil?
                  @removed = Towser::Network::Switch::Attribute::Vlans.new(switchport[:vlans][:remove])
                end
              end

              @acceptable_frame_type = switchport[:acceptable_frame_type]
            end

            def to_hash
              {
                :mode => mode,
                :added => added.to_hash,
                :removed => removed,
                :acceptable_frame_type => acceptable_frame_type,
              }
            end

            alias_method :inspect, :to_hash
            alias_method :to_s, :to_hash
          end
        end
      end
    end
  end
end
