#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      class BridgeAddressTable
        attr_reader :entries

        def initialize(table)
          @table   = table
          @entries = {}

          self.objectify
        end

        def objectify
          @table.each do |identifier, entry|
            @entries[identifier] = Towser::Network::Switch::BridgeAddressTable::Entry.new(identifier, entry)
          end
        end

        def find_macs_for_port(stack_member, unit, port)
          entries.each do |identifier, entry|
            if entry.stack_member == stack_member and entry.unit == unit and entry.port == port
              return entry.vlans.vlans
            end
          end
          return
        end
      end
    end
  end
end
