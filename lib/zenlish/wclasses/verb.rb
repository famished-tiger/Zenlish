require_relative 'word_class'

module Zenlish
  module WClasses
    # Abstract class. In traditional grammar, the verb is often defined 
    # notionally as a 'doing' word (i.e. a word that describes the action
    # in a clause).
    class Verb < WordClass
    
      # As all verbs inflect, or change form, to reflect changes in tense,
      # person, number, and voice, they are, by definition, variable.
      def invariable?
        false
      end
    end # class
  end # module
end # module