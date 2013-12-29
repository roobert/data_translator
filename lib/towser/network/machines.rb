#!/usr/bin/env ruby

module Towser
  class Network
    class Machines
      attr_accessor :config, :machines

      def initialize
        @machines = {}
      end

      def add(config)
        @config = config

        objectify
      end

      def objectify
        @config.each do |hostname, data|
          @machines[hostname] = Machine.new(data)
        end
      end

      def to_hash
        { :machines => machines }
      end

      # associate each machine interface MAC address with a switch port
      def combine_data(switches)
        switches
      end

      alias_method :inspect, :to_hash
      alias_method :to_s, :to_hash
    end
  end
end
