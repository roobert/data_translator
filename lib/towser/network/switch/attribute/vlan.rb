#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      module Attribute
        class Vlan
          attr_accessor :identifier, :macs

          def initialize(identifier, data)
            @identifier = identifier.to_i

            objectify(data)
          end

          def objectify(data)
            data.each do |mac, mode|
              @macs ||= []
              @macs.push({ :mac => mac, :mode => mode })
            end
          end
        end
      end
    end
  end
end
