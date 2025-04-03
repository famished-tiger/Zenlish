# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/trie/trie' # Load the class under test

module Zenlish
  module Trie
    describe Trie do
      subject(:trie) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end

        it 'is a leaf node at start' do
          expect(trie.root).to be_a(TrieRoot)
        end
      end # context

      context 'Provided services:' do
        it 'accepts the addition of one single node' do
          expect { trie.add('a', 'OK') }.not_to raise_error
          expect(trie.root).to include('a')
          expect(trie.root.succ['a']).to be_a(TrieNode)
          expect(trie.root.succ['a'].value).to eq('OK')
        end

        it 'accepts the addition of a node string' do
          expect { trie.add('abc', 'OK') }.not_to raise_error
          expect(trie.root).to include('a')
          expect(trie.root).not_to include('b')

          node_a = trie.root.succ['a']
          expect(node_a).to be_a(TrieNode)
          expect(node_a.value).to be_nil
          expect(node_a).to include('b')
          expect(node_a).not_to include('c')

          node_b = node_a.succ['b']
          expect(node_b).to be_a(TrieNode)
          expect(node_b.value).to be_nil
          expect(node_b).to include('c')

          node_c = node_b.succ['c']
          expect(node_c).to be_a(TrieNode)
          expect(node_c.value).to eq('OK')
          expect(node_c).to be_leaf
        end

        it 'accepts the addition of multiple node strings' do
          trie.add('abc', 'ABC')
          expect { trie.add('abe', 'ABE') }.not_to raise_error
          root = trie.root
          expect(root).to include('a')
          expect(root).not_to include('b')

          node_a = root.succ['a']

          node_b = node_a.succ['b']
          expect(node_b).to be_a(TrieNode)
          expect(node_b.value).to be_nil
          expect(node_b).to include('c')
          expect(node_b).to include('e')

          node_c = node_b.succ['c']
          expect(node_c).to be_a(TrieNode)
          expect(node_c.value).to eq('ABC')
          expect(node_c).to be_leaf

          node_e = node_b.succ['e']
          expect(node_e).to be_a(TrieNode)
          expect(node_e.value).to eq('ABE')
          expect(node_e).to be_leaf
        end

        it 'retrieves the node matching a given string' do
          trie.add('abc', 'ABC')
          trie.add('hello', 'WORLD')
          trie.add('hellene', 'GREEK')

          hello_node = trie.search('hello')
          expect(hello_node.key).to eq('o')
          expect(hello_node.value).to eq('WORLD')
          hellish = trie.search('hell')
          expect(hellish.key).to eq('l')
          expect(hellish.value).to be_nil
          expect(trie.search('greeting')).to be_nil
          hellene_node = trie.search('hellene')
          expect(hellene_node.key).to eq('e')
          expect(hellene_node.value).to eq('GREEK')
          expect(trie.search('hellenes')).to be_nil
        end

        it 'accepts the addition of "synonyms"' do
          trie.add('abd', 'first')
          trie.add('abduce', 'ABDUCE')

          abd_node = trie.search('abd')
          expect(abd_node.value).to eq('first')

          trie.add('abd', 'second')
          expect(abd_node.value).to eq(%w[first second])
        end
      end # context
    end # describe
  end # module
end # module
