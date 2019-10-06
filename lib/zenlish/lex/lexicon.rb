module Zenlish
  module Lex
    # A lexicon is a collection of lexical entries.
    # Every entry is associated with one one more lexemes.
    class Lexicon
      attr_reader :entries
      attr_reader :lemma2entry

      # The list of terminal symbols. Examples of terminal symbols:
      # - word classes,
      # - punctuation signs,...
      attr_reader :terminals
      attr_reader :name2terminal

      def initialize
        @entries = []
        @lemma2entry = {}
        @terminals = []
        @name2terminal = {}
      end

      def get_lexeme(aLemma)
        lemma2entry.fetch(aLemma).lexemes.first
      end

      def add_terminal(aTerminal)
        terminals << aTerminal
        name2terminal[aTerminal.name] = aTerminal
      end

      def add_entry(anEntry)
        entries << anEntry
        lemma = anEntry.lemma

        update_mapping(lemma2entry, lemma, anEntry)
      end

      private

      def update_mapping(aHash, aKey, aValue)
        if aHash.include?(aKey)
          hit = aHash[aKey]
          if hit.is_a?(Array)
            hit << aValue
          else
            aHash[aKey] = [hit, aValue]
          end
        else
          aHash[aKey] = aValue
        end
      end

    end # class
  end # module
end # module
