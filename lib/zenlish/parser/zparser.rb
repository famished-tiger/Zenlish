# frozen_string_literal: true

require_relative 'zenlish_grammar'

module Zenlish
  class ZParser
    attr_reader(:engine)

    def initialize
      # Create a Rley facade object
      @engine = Rley::Engine.new

      # Step 1. Load Zenlish grammar
      @engine.use_grammar(ZenlishGrammar)
    end

    def parse(tokenSeq)
      result = engine.parse(tokenSeq)

      unless result.success?
        # Stop if the parse failed...
        line1 = "Parsing failed\n"
        line2 = "Reason: #{result.failure_reason.message}"
        raise StandardError, line1 + line2
      end

      return engine.to_ptree(result)
    end
  end # class
end # module
