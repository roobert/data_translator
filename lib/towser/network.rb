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


    def normalize_mac(mac)
      mac.downcase.gsub(/[^0-9a-zA-Z]*/, '')
    end

    def machine(hostname)
      @machines.machines.each do |machine_identifier, machine|
        return machine if hostname == machine_identifier
      end
    end

    # find out which switch ports a machines interface is visible on
    def find_switch_ports(machine_mac)

      ports = nil

      @switches.switches.each do |switch_identifier, switch|

        switch.config.ethernet_interfaces.each do |interface_identifier, interface|

          next if interface.switchport.nil?
          next if interface.switchport.added.nil?

          interface.switchport.added.each do |vlan, vlans|

            vlans.macs.each do |mac, mode|

              if normalize_mac(mac) == normalize_mac(machine_mac)
                ports = {} if ports.nil?
                ports[switch_identifier] ||= {}
                ports[switch_identifier][interface_identifier] ||= {}
                ports[switch_identifier][interface_identifier][vlan] ||= { mac => mode }
              end
            end
          end
        end
      end

      ports
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
