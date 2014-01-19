#!/usr/bin/env ruby

module NetworkDataTranslator
  class Network
    class Machines
      class Machine
        class Interface
          attr_accessor :identifier, :mac_address, :member, :active_interface, :ip_addresses, :slaves, :active_in_bond, :switch_ports

          def initialize(identifier, data)
            @identifier       = identifier
            @mac_address      = data['mac_address']
            @member           = data['member']
            @active_interface = data['active_interface']
            @ip_addresses     = data['ip_addresses']
            @slaves           = data['slaves']
            @active_in_bond   = data['active_in_bond']
          end
        end
      end
    end
  end
end
