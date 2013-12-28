#!/usr/bin/env ruby

module Towser
  class Network
    attr_accessor :switches, :machines

    def initialize
      @switches = Switches.new
      @machines = Machines.new
    end

    def add_switches(switches)
      @switches.add(switches)
    end

    def add_machines(machines)
      @machines.add(machines)
    end

    def to_hash
      {
        :switches => @switches.to_hash,
        :machines => @machines.to_hash
      }
    end

    alias_method :to_s, :to_hash
    alias_method :inspect, :to_hash
  end
end
