# frozen_string_literal: true

require_relative '../lang/zenlish_grammar'

module Zenlish
  class ZParser
    # @!attribute [r] engine
    #   @return [Rley::Engine] Facade object of Rley library
    attr_reader(:engine)

    def initialize
      # Create a Rley facade object
      @engine = Rley::Engine.new do |config|
        config.diagnose = true
      end

      # Step 1. Load Zenlish grammar
      @engine.use_grammar(ZenlishGrammar)
    end

    # Parse the sequence of words into a parse tree.
    # @raise [StandardError] Fails when the parse is ambiguous.
    # @return [Rley::PTree;;ParseTree] the resulting parse tree.
    def parse(tokenSeq)
      result = earley_parse(tokenSeq)

      # Convert into a parse tree
      engine.to_ptree(result)
    end

    alias to_ptree parse

    # Parse the sequence of words into a parse forest.
    # Parse forests are needed when dealing with ambiguous input.
    # @return [Rley::SPPF::ParseForest] the resulting parse forest.
    def to_pforest(tokenSeq)
      result = earley_parse(tokenSeq)
      # puts result

      # Convert into a parse forest
      engine.to_pforest(result)
    end

    private

    def earley_parse(tokenSeq)
      result = engine.parse(tokenSeq)

      unless result.success?
        # Stop if the parse failed...
        line1 = "Parsing failed\n"
        line2 = "Reason: #{result.failure_reason.message}"
        raise StandardError, line1 + line2
      end

      result
    end
  end # class
end # module
