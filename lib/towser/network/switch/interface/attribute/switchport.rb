#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      module Interface
        module Attribute
          class Switchport

            def initialize(switchport)
              objectify(switchport)
            end

            def objectify(switchport)
              @access  = Access.new(switchport[:access])   unless switchport[:access].nil?
              @mode    = switchport[:mode]                 unless switchport[:mode].nil?
              @trunk   = Trunk.new(switchport[:trunk])     unless switchport[:trunk].nil?
              @general = General.new(switchport[:general]) unless switchport[:general].nil?
            end

            class Access
              def initialize(data)
                @vlans = Towser::Network::Switch::Attribute::Vlans.new(data[:vlans]) unless data[:vlans].nil?
              end
            end

            class Trunk
              def initialize(data)
                @tagged  = Tagged.new(data[:tagged])   unless data[:tagged].nil?
                @allowed = Allowed.new(data[:allowed]) unless data[:allowed].nil?
              end

              class Tagged
                def initialize(data)
                  @tagged = data unless data.nil?
                end
              end

              class Allowed
                def initialize(data)
                  unless data[:vlans].nil?
                    @allowed = Add.new(data[:vlans][:add])       unless data[:vlans][:add].nil?
                    @allowed = Remove.new(data[:vlans][:remove]) unless data[:vlans][:remove].nil?
                  end
                end

                class Add
                  def initialize(data)
                    @vlans = Towser::Network::Switch::Attribute::Vlans.new(data) unless data.nil?
                  end
                end

                class Remove
                  def initialize(data)
                    @vlans = Towser::Network::Switch::Attribute::Vlans.new(data) unless data.nil?
                  end
                end
              end
            end

            class General
              def initialize(data)
                @tagged                = Tagged.new(data[:tagged])                             unless data[:tagged].nil?
                @allowed               = Allowed.new(data[:allowed])                           unless data[:allowed].nil?
                @acceptable_frame_type = AcceptableFrameType.new(data[:acceptable_frame_type]) unless data[:acceptable_frame_type].nil?
              end

              class Tagged
                def initialize(data)
                  @tagged = data unless data.nil?
                end
              end

              class Allowed
                def initialize(data)
                  unless data[:vlans].nil?
                    @allowed = Add.new(data[:vlans][:add])       unless data[:vlans][:add].nil?
                    @allowed = Remove.new(data[:vlans][:remove]) unless data[:vlans][:remove].nil?
                  end
                end

                class Add
                  def initialize(data)
                    @vlans = Towser::Network::Switch::Attribute::Vlans.new(data) unless data.nil?
                  end
                end

                class Remove
                  def initialize(data)
                    @vlans = Towser::Network::Switch::Attribute::Vlans.new(data) unless data.nil?
                  end
                end
              end

              class AcceptableFrameType
                def initialize(data)
                  @acceptable_frame_type = data unless data.nil?
                end
              end
            end
          end
        end
      end
    end
  end
end
