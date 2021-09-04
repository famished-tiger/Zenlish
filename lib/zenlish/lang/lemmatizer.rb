# frozen_string_literal: true

require_relative '../trie/trie'

module Zenlish
  module Lang
    class Lemmatizer
      # @return [Trie:Trie] Trie (aka prefix tree) with all word forms from dictionary.
      attr_reader :trie

      def initialize(aLexicon)
        @trie = Trie::Trie.new
        initialize_trie(aLexicon)
      end

      def lemmatize(aWordForm, _hints = nil)
        node = trie.search(aWordForm)
        node&.value
      end

      private

      def initialize_trie(aLexicon)
        aLexicon.entries.each do |ent|
          citation_form = ent.lemma
          ent.lexemes.each do |lxm|
            if lxm.wclass.kind_of?(Zenlish::WClasses::WordClass)
              if lxm.wclass.invariable?
                trie.add(citation_form, lxm)
              else
                w_forms = lxm.all_inflections
                w_forms.each { |form| trie.add(form, lxm) }
              end
            end
          end
        end
      end
    end # class
  end # module
end # module
