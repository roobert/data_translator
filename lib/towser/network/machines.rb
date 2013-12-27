#!/usr/bin/env ruby

module Towser
  class Network
    class Machines
      attr_accessor :config, :machines

      def initialize(config)
        @config   = config
        @machines = {}

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

      def normalize_mac(mac)
        mac.downcase.gsub(/[^0-9a-zA-Z]*/, '')
      end

      def find_machine(mac)
        @machines.each do |hostname, machine|
          machine.interfaces.each do |interface, interface_data|
            #puts "no match: #{hostname}: #{normalize_mac(interface_data.mac_address)} == #{normalize_mac(mac)}"
            if normalize_mac(interface_data.mac_address) == normalize_mac(mac)
              puts "match found: #{hostname}: #{normalize_mac(interface_data.mac_address)} == #{normalize_mac(mac)}"
              puts "interface: #{interface}"
              puts "hostname: #{hostname}"
              #ap machine
            end
          end
        end
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
