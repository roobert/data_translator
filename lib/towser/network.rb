#!/usr/bin/env ruby

module Towser
  class Network
    attr_accessor :switches, :machines

    def initialize(switches)
      @switches = Switches.new
      @machines = Machines.new
    end

    def add_switches(switches)
      switches.add(switches)
    end

    def add_machines(machines)
      machines.add(machines)
    end
  end
end
