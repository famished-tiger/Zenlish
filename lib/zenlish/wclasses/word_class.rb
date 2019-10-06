require 'rley'

module Zenlish
  module WClasses
    # Also known as: part of speech, syntactic category or word category.
    # A word class represents a group of word which have similar functions.
    # Word classes are divided into:
    # - Lexical words (?? same as content words??) such as nouns, verbs, adjectives, adverbs
    #   Content words carry the meaning of a sentence
    # - Function words (?? same as structure words??) such as pronouns, determiners, modal verbs, 
    #  auxiliary verbs,
    #   Structure words structure a sentence
    #   conjunctions and prepositions
    class WordClass < Rley::Syntax::Terminal
      def initialize
        super(self.class.name.split('::').last)
      end
    end # class
  end # module    
end # module