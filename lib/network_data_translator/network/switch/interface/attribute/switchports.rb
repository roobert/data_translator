#!/usr/bin/env ruby

module NetworkDataTranslator
  class Network
    class Switch
      module Interface
        module Attribute
          class Switchports
            attr_reader :switchports

            def initialize(switchports)
              @switchports = []
              objectify(switchports)
            end

            def objectify(switchports)
              switchports.each do |switchport|
                @switchports.push NetworkDataTranslator::Network::Switch::Interface::Attribute::Switchport.new(switchport)
              end
            end

            def each
              @switchports.each { |switchport| yield switchport }
            end
          end
        end
      end
    end
  end
end
