#!/usr/bin/env ruby

module NetworkDataTranslator
  class Network
    class Switch
      class Config
        attr_accessor :ethernet_interfaces, :vlan_interfaces, :port_channel_interfaces

        def initialize(config)
          @ethernet_interfaces     = []
          @vlan_interfaces         = []
          @port_channel_interfaces = []

          self.objectify(config)
        end

        def objectify(config)
          config[:interface].each do |type, interfaces|

            case type

            when :ethernet
              interfaces.each do |identifier, interface|
                @ethernet_interfaces.push NetworkDataTranslator::Network::Switch::Interface::Ethernet.new(identifier, interface)
              end

            when :vlan
              interfaces.each do |identifier, interface|
                @vlan_interfaces.push NetworkDataTranslator::Network::Switch::Interface::Vlan.new(identifier, interface)
              end

            when :port_channel
              interfaces.each do |identifier, interface|
                @port_channel_interfaces.push NetworkDataTranslator::Network::Switch::Interface::PortChannel.new(identifier, interface)
              end

            else
              raise StandardError, "unknown interface type: #{type}"
            end
          end
        end
      end
    end
  end
end
