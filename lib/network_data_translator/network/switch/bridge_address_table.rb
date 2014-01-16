#!/usr/bin/env ruby

module NetworkDataTranslator
  class Network
    class Switch
      class BridgeAddressTable
        attr_reader :entries

        def initialize(table)
          @entries = []

          self.objectify(table)
        end

        def objectify(table)
          table.each do |identifier, entry|
            @entries.push NetworkDataTranslator::Network::Switch::BridgeAddressTable::Entry.new(identifier, entry)
          end
        end

        def each
          @entries.each { |entry| yield entry }
        end
      end
    end
  end
end
