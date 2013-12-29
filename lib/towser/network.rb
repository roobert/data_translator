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

    def associate_machine_interfaces_with_switch_ports
      return if @machines.nil?
      return if @machines.machines.nil?

      @machines.machines.each do |machine_identifier, machine|

        machine.interfaces.each do |interface_identifier, interface|
          interface.switch_ports = find_switch_ports_by_mac(interface.mac_address)
        end
      end
    end

    def find_machine_ports(hostname)
      machine = find_machine_by_hostname(hostname)

      return if machine.nil?

      found_ports = {}

      machine.interfaces.each do |interface_identifier, interface|
        ports = find_switch_ports_by_mac(interface.mac_address)
        found_ports[interface_identifier] = ports unless ports.nil?
      end

      ap machine

      return nil if found_ports.empty?
      return found_ports
    end

    def find_machine_by_ip(mac)
    end

    def find_machine_by_mac(mac)
    end

    def find_machine_by_hostname(hostname)
      @machines.machines.each do |machine_identifier, machine|
        return machine if hostname == machine_identifier
      end
    end

    # find out which switch ports a machines interface is visible on
    def find_switch_ports_by_mac(machine_mac)

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
