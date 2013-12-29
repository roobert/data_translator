#!/usr/bin/env ruby

module Towser
  class Network
    attr_accessor :switches, :machines

    def initialize(identifier)
      @identifier = identifier
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

    # these two tasks are essentially 'combine_machine_data' so maybe they should be moved?

    def associate_switch_port_mac_addresses_with_machine_interfaces
      @switches.each do |switch|

        switch.config.ethernet_interfaces.each do |interface|

          next if interface.switchport.nil?
          next if interface.switchport.added.nil?

          interface.switchport.added.each do |vlans|

            vlans.macs.each do |data|

              machine = find_machine_by_mac(data)

              unless machine.nil?
                vlans.macs.each do |mac|
                end
              end
            end
          end
        end
      end

      return
    end

    def associate_machine_interfaces_with_switch_ports
      return if @machines.nil?

      @machines.each do |machine|

        machine.interfaces.each do |interface|
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

      return nil if found_ports.empty?
      return found_ports
    end

    def find_machine_by_ip(mac)
    end

    def find_machine_by_mac(mac)
      @machines.each do | machine|
        machine.interfaces.each do |interface|
          next if interface.mac_address.nil?

          if normalize_mac(mac[:mac]) == normalize_mac(interface.mac_address)
            return { machine.identifier => machine }
          end
        end
      end

      return
    end

    def find_machine_by_hostname(hostname)
      @machines.machines.each do |machine_identifier, machine|
        return machine if hostname == machine_identifier
      end
    end

    # find out which switch ports a machines interface is visible on
    def find_switch_ports_by_mac(machine_mac)

      ports = nil

      @switches.each do |switch|

        switch.config.ethernet_interfaces.each do |interface|

          next if interface.switchport.nil?
          next if interface.switchport.added.nil?

          interface.switchport.added.vlans.each do |vlan|

            vlan.macs.each do |data|
                if normalize_mac(data[:mac]) == normalize_mac(machine_mac)
                  ports = {} if ports.nil?
                  ports[switch.identifier] ||= {}
                  ports[switch.identifier][interface.identifier] ||= {}
                  ports[switch.identifier][interface.identifier][vlan] ||= data
                end
            end
          end
        end
      end

      ports
    end
  end
end
