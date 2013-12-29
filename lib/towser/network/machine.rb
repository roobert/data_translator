#!/usr/bin/env ruby

module Towser
  class Network
    class Machines
      class Machine
        attr_accessor :identifier, :interfaces

        def initialize(identifier, config)
          @identifier = identifier
          @interfaces = []

          objectify(config)
        end

        def objectify(config)
          config.each do |identifier, data|
            @interfaces.push Interface.new(identifier, data)
          end
        end
      end
    end
  end
end
