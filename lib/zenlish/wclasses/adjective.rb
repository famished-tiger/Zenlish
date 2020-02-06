require_relative 'word_class'

module Zenlish
  module WClasses
    # TODO: document
    class Adjective < WordClass
      # @return [FalseClass] Indicates that an adjective may inflect.
      def invariable?
        false
      end    
    end # class
  end # module
end # module
