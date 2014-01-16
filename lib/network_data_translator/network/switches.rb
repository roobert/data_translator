#!/usr/bin/env ruby

module NetworkDataTranslator
  class Network
    class Switches
      attr_reader :switches

      def initialize
        @switches = []
      end

      def [](n)
        @switches[n]
      end

      def each
        @switches.each { |switch| yield switch }
      end

      def add(host)
        @switches.push NetworkDataTranslator::Network::Switch.new(host)
      end
    end
  end
end
