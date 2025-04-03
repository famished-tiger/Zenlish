# frozen_string_literal: true

require_relative 'lexical_verb'

module Zenlish
  module WClasses
    module IrregularVerbExtension
      # This callback when the module is extending an object.
      # Purpose: to inject a number of instance variables in the host
      # def extended(host)
      def init_extension(host)
        host.instance_variable_set(:@forms, [])
      end

      # @param theForm [Hash{Symbol => String}]
      def forms(theForms)
        valid_symbols = %i[past_simple past_participle]
        actual_symbols = theForms.keys
        actual_symbols.each do |symb|
          raise StandardError, "Invalid verb form #{symb}" unless valid_symbols.include?(symb)
        end
        if actual_symbols.size < valid_symbols.size
          missing = valid_symbols.find { |symb| !actual_symbols.include?(symb) }
          raise StandardError, "Missing form #{missing}"
        end
        @forms = [nil, nil]
        @forms[0] = theForms[valid_symbols[0]]
        @forms[1] = theForms[valid_symbols[1]]
      end

      def past_simple
        @forms.first
      end

      def past_participle
        @forms.last
      end
    end # class
  end # module
end # module
