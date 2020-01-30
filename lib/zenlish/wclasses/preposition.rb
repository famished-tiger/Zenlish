require_relative 'word_class'

module Zenlish
  module WClasses
    # TODO: document
    class Preposition < WordClass
    
      # Prepositions do not inflect, so they're invariable.
      def invariable?
        true
      end    
    end # class
  end # module
end # module
