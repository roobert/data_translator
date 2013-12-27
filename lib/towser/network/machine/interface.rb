#!/usr/bin/env ruby

module Towser
  class Network
    class Machines
      class Machine
        class Interface
          attr_accessor :mac_address, :member, :active_interface, :ip_addresses, :slaves, :active_in_bond

          def initialize(data)
            @mac_address      = data[:mac_address]
            @member           = data[:member]
            @active_interface = data[:active_interface]
            @ip_addresses     = data[:ip_addresses]
            @slaves           = data[:slaves]
            @active_in_bond   = data[:active_in_bond]
          end

          def to_hash
            {
              :mac_address      => mac_address,
              :member           => member,
              :active_interface => active_interface,
              :ip_addresses     => ip_addresses,
              :slaves           => slaves,
              :active_in_bond   => active_in_bond,
            }
          end

          alias_method :inspect, :to_hash
          alias_method :to_s, :to_hash
        end
      end
    end
  end
end
