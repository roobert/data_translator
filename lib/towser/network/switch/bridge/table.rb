#!/usr/bin/env ruby

module Towser
  class Network
    class Switch
      module Bridge
        class Table
          attr_reader :entries

          def initialize(table)
            @table   = table
            @entries = {}

            self.objectify
          end

          def objectify
            @table.each do |identifier, entry|
              @entries[identifier] = Towser::Network::Switch::Bridge::Entry.new(identifier, entry)
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

          def to_hash
            {
              :entries => @entries.to_hash
            }
          end

          alias_method :inspect, :to_hash
          alias_method :to_s, :to_hash
        end
      end
    end
  end
end
