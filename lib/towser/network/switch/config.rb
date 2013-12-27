#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      class Config
        attr_accessor :ethernet_interfaces, :vlan_interfaces, :port_channel_interfaces

        def initialize(config)
          @config                  = config
          @ethernet_interfaces     = {}
          @vlan_interfaces         = {}
          @port_channel_interfaces = {}

          self.objectify
        end

        def objectify
          @config[:interface].each do |type, interfaces|

            case type

            when :ethernet
              interfaces.each do |identifier, interface|
                @ethernet_interfaces[identifier] = Towser::Network::Switch::Interface::Ethernet.new(identifier, interface)
              end

            when :vlan
              interfaces.each do |identifier, interface|
                @vlan_interfaces[identifier] = Towser::Network::Switch::Interface::Vlan.new(identifier, interface)
              end

            when :port_channel
              interfaces.each do |identifier, interface|
                @port_channel_interfaces[identifier] = Towser::Network::Switch::Interface::PortChannel.new(identifier, interface)
              end

            else
              raise StandardError, "unknown interface type: #{type}"
            end
          end
        end

        def to_hash
          {
            :ethernet_interfaces     => @ethernet_interfaces.to_hash,
            :vlan_interfaces         => @vlan_interfaces.to_hash,
            :port_channel_interfaces => @port_channel_interfaces.to_hash
          }
        end

        alias_method :inspect, :to_hash
        alias_method :to_s, :to_hash
      end
    end
  end
end
