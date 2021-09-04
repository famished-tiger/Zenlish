# frozen_string_literal: true

require_relative 'trie_root'
require_relative 'trie_node'

# https://raw.githubusercontent.com/first20hours/google-10000-english/master/20k.txt
# https://raw.githubusercontent.com/dwyl/english-words/master/words_alpha.txt

module Zenlish
  module Trie
    # A trie (aka prefix tree or digital tree) is a kind of search tree.
    class Trie
      #  @return [TrieRoot] The root node of the trie data structure
      attr_reader :root

      def initialize
        @root = TrieRoot.new
      end

      def add(aWord, aValue)
        append_node(root, aWord, 0, aValue)
      end

      def search(aWord)
        search_node(root, aWord, 0)
      end

      private

      def append_node(aNode, aText, anIndex, aValue)
        key = aText[anIndex]
        unless aNode.include?(key)
          aNode.add_succ(key, TrieNode.new(key))
        end
        successor = aNode.succ[key]

        if anIndex == aText.size - 1
          current_value = successor.value
          if current_value
            if current_value.kind_of?(Array)
              current_value << aValue
            else
             successor.value = [current_value, aValue]
            end
          else
            successor.value = aValue
          end
        else
          append_node(successor, aText, anIndex + 1, aValue)
        end
      end

      def search_node(aNode, aText, anIndex)
        key = aText[anIndex]
        return nil unless aNode.include?(key)

        successor = aNode.succ[key]
        return successor if anIndex == aText.size - 1

        search_node(successor, aText, anIndex + 1)
      end
=begin


      def include?(word)
        find_word(word) { |found, base| return found && base.word }
      end

      def add_word(word)
        letters = word.chars
        base    = @root

        letters.each { |letter| base = add_character(letter, base.next) }

        base.word = true
      end

      def find_word(word)
        letters = word.chars
        base    = @root

        word_found =
        letters.all? { |letter| base = find_character(letter, base.next) }

        yield word_found, base if block_given?

        base
      end

      def find_words_starting_with(prefix)
        stack        = []
        words        = []
        prefix_stack = []

        stack        << find_word(prefix)
        prefix_stack << prefix.chars.take(prefix.size-1)

        return [] unless stack.first

        until stack.empty?
          node = stack.pop

          prefix_stack.pop and next if node == :guard_node

          prefix_stack << node.value
          stack        << :guard_node

          words << prefix_stack.join if node.word

          node.next.each { |n| stack << n }
        end

        words
      end

      private

      def add_character(character, trie)
        trie.find { |n| n.value == character } || add_node(character, trie)
      end

      def find_character(character, trie)
        trie.find { |n| n.value == character }
      end

      def add_node(character, trie)
        TrieNode.new(character).tap { |new_node| trie << new_node }
      end
=end
    end # class
  end # module
end # module
