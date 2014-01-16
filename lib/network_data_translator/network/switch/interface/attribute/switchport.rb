#!/usr/bin/env ruby

module NetworkDataTranslator
  class Network
    class Switch
      module Interface
        module Attribute
          class Switchport

            attr_reader :mode, :type

            def initialize(switchport)
              objectify(switchport)
            end

            def objectify(switchport)
              @type, @mode = nil, nil

              @mode = switchport[:mode]                 unless switchport[:mode].nil?
              @type = Access.new(switchport[:access])   unless switchport[:access].nil?
              @type = Trunk.new(switchport[:trunk])     unless switchport[:trunk].nil?
              @type = General.new(switchport[:general]) unless switchport[:general].nil?
            end

            class Access
              attr_reader :vlans

              def initialize(data)
                @vlans = nil

                @vlans = NetworkDataTranslator::Network::Switch::Attribute::Vlans.new(data[:vlans]) unless data[:vlans].nil?
              end
            end

            class Trunk
              attr_reader :tagged, :allowed

              def initialize(data)
                @tagged, @allowed = nil, nil

                @tagged  = Tagged.new(data[:tagged])   unless data[:tagged].nil?
                @allowed = Allowed.new(data[:allowed]) unless data[:allowed].nil?
              end

              class Tagged
                attr_reader :tagged

                def initialize(data)
                  @tagged = nil

                  @tagged = data unless data.nil?
                end
              end

              class Allowed
                attr_reader :allowed

                def initialize(data)
                  @allowed = nil

                  unless data[:vlans].nil?
                    @allowed = Add.new(data[:vlans][:add])       unless data[:vlans][:add].nil?
                    @allowed = Remove.new(data[:vlans][:remove]) unless data[:vlans][:remove].nil?
                  end
                end

                class Add
                  attr_reader :vlans

                  def initialize(data)
                    @vlans = nil

                    @vlans = NetworkDataTranslator::Network::Switch::Attribute::Vlans.new(data) unless data.nil?
                  end
                end

                class Remove
                  attr_reader :vlans

                  def initialize(data)
                    @vlans = nil

                    @vlans = NetworkDataTranslator::Network::Switch::Attribute::Vlans.new(data) unless data.nil?
                  end
                end
              end
            end

            class General
              attr_accessor :allowed, :tagged, :acceptable_frame_type

              def initialize(data)
                @tagged, @allowed, @acceptable_frame_type = nil, nil, nil

                @tagged                = Tagged.new(data[:tagged])                             unless data[:tagged].nil?
                @acceptable_frame_type = AcceptableFrameType.new(data[:acceptable_frame_type]) unless data[:acceptable_frame_type].nil?
                @allowed               = Allowed.new(data[:allowed])                           unless data[:allowed].nil?
              end

              class Tagged
                attr_accessor :tagged

                def initialize(data)
                  @tagged = nil

                  @tagged = data unless data.nil?
                end
              end

              class AcceptableFrameType
                attr_accessor :acceptable_frame_type

                def initialize(data)
                  @acceptable_frame_type = nil

                  @acceptable_frame_type = data unless data.nil?
                end
              end

              class Allowed
                attr_accessor :allowed

                def initialize(data)
                  @allowed = nil

                  unless data[:vlans].nil?
                    @allowed = Add.new(data[:vlans][:add])       unless data[:vlans][:add].nil?
                    @allowed = Remove.new(data[:vlans][:remove]) unless data[:vlans][:remove].nil?
                  end
                end

                class Add
                  def initialize(data)
                    @vlans = nil

                    @vlans = NetworkDataTranslator::Network::Switch::Attribute::Vlans.new(data) unless data.nil?
                  end
                end

                class Remove
                  def initialize(data)
                    @vlans = nil

                    @vlans = NetworkDataTranslator::Network::Switch::Attribute::Vlans.new(data) unless data.nil?
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
