#!/usr/bin/env ruby

module NetworkDataTranslator
  class Network
    attr_accessor :identifier, :switches, :machines

    def initialize(identifier)
      @identifier = identifier
      @switches = Switches.new
      @machines = Machines.new
    end

    # add each switch individually
    def add_switches(switches)
      switches.each { |switch| @switches.add(switch) }
    end

    # machines comes in the form of a giant hash..
    def add_machines(machines)
      @machines.add(machines)
    end
  end
end
