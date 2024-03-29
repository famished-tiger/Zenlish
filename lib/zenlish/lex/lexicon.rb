# frozen_string_literal: true

module Zenlish
  module Lex
    # A lexicon is a collection of lexical entries.
    # Every entry is associated with one one more lexemes.
    class Lexicon
      # @return [Array<Lex::LexicalEntry>] entries in the lexicon
      attr_reader :entries

      # @return [Hash{String => Lex::LexicalEntry}] the lexical entry for the given lemma.
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

      # @param aLemma[String] retrieve the lexeme form the given "head word".
      # @param aWordClass [WordClasses::WordClass, NilClass] the word class of
      #   the lexeme.
      # @return [Lex::Lexeme]
      def get_lexeme(aLemma, aWordClass = nil)
        if aWordClass
          lexeme = nil
          candidate = nil

          entries = lemma2entry.fetch(aLemma)
          if entries.kind_of?(Array)
            entries.each do |e|
              candidate = e.lexemes.first
              break if candidate.wclass.kind_of?(aWordClass)
            end
            lexeme = candidate
          else
            candidate = entries.lexemes.first
            lexeme = candidate if candidate.wclass.kind_of?(aWordClass)
          end

          lexeme
        else
          entry = lemma2entry.fetch(aLemma)
          if entry.kind_of?(Array)
            err_msg = "Multiple lexemes for #{aLemma}"
            raise StandardError, err_msg
          else
            entry.lexemes.first
          end
        end
      end

      # @param aTerminal [Rley::Syntax::Terminal]
      def add_terminal(aTerminal)
        terminals << aTerminal
        name2terminal[aTerminal.name] = aTerminal
      end

      # @param anEntry [Lex::LexicalEntry]
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
