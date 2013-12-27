#!/usr/bin/env ruby

module Towser
  class Network
    def initialize(switches)
      @switches = Switches.new
    end

    def add_switches(switches)
      @switches.add(switches)
    end
  end
end
