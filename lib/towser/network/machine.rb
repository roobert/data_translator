#!/usr/bin/env ruby

module Towser
  class Network
    class Machines
      class Machine
        attr_accessor :mac_address, :interfaces

        def initialize(data)
          @data       = data
          @interfaces = {}

          objectify
        end

        def objectify
          @data.each do |interface, data|
            @interfaces[interface] = Interface.new(data)
          end
        end

        def to_hash
          { :interfaces => interfaces }
        end

        alias_method :inspect, :to_hash
        alias_method :to_s, :to_hash
      end
    end
  end
end
