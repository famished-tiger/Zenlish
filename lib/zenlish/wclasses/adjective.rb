require_relative 'word_class'

module Zenlish
  module WClasses
    # TODO: document
    class Adjective < WordClass
      # @return [FalseClass] Indicates that an adjective may inflect.
      def invariable?
        # TODO: set to false once we introduce the degrees (basic, comparative, superlative)
        true 
      end    
    end # class
  end # module
end # module
