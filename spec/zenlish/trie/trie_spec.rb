# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/trie/trie' # Load the class under test

module Zenlish
  module Trie
    describe Trie do
      subject { Trie.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { Trie.new }.not_to raise_error
        end

        it 'should be a leaf node at start' do
          expect(subject.root).to be_kind_of(TrieRoot)
        end
      end # context

      context 'Provided services:' do
        it 'should accept the addition of one single node' do
          expect { subject.add('a', 'OK') }.not_to raise_error
          expect(subject.root.include?('a')).to be_truthy
          expect(subject.root.succ['a']).to be_kind_of(TrieNode)
          expect(subject.root.succ['a'].value).to eq('OK')
        end

        it 'should accept the addition of a node string' do
          expect { subject.add('abc', 'OK') }.not_to raise_error
          expect(subject.root.include?('a')).to be_truthy
          expect(subject.root.include?('b')).to be_falsy

          node_a = subject.root.succ['a']
          expect(node_a).to be_kind_of(TrieNode)
          expect(node_a.value).to be_nil
          expect(node_a.include?('b')).to be_truthy
          expect(node_a.include?('c')).to be_falsy

          node_b = node_a.succ['b']
          expect(node_b).to be_kind_of(TrieNode)
          expect(node_b.value).to be_nil
          expect(node_b.include?('c')).to be_truthy

          node_c = node_b.succ['c']
          expect(node_c).to be_kind_of(TrieNode)
          expect(node_c.value).to eq('OK')
          expect(node_c).to be_leaf
        end

        it 'should accept the addition of multiple node strings' do
          subject.add('abc', 'ABC')
          expect { subject.add('abe', 'ABE') }.not_to raise_error
          root = subject.root
          expect(root.include?('a')).to be_truthy
          expect(root.include?('b')).to be_falsy

          node_a = root.succ['a']

          node_b = node_a.succ['b']
          expect(node_b).to be_kind_of(TrieNode)
          expect(node_b.value).to be_nil
          expect(node_b.include?('c')).to be_truthy
          expect(node_b.include?('e')).to be_truthy

          node_c = node_b.succ['c']
          expect(node_c).to be_kind_of(TrieNode)
          expect(node_c.value).to eq('ABC')
          expect(node_c).to be_leaf

          node_e = node_b.succ['e']
          expect(node_e).to be_kind_of(TrieNode)
          expect(node_e.value).to eq('ABE')
          expect(node_e).to be_leaf
        end

        it 'should retrieve the node matching a given string' do
          subject.add('abc', 'ABC')
          subject.add('hello', 'WORLD')
          subject.add('hellene', 'GREEK')

          hello_node = subject.search('hello')
          expect(hello_node.key).to eq('o')
          expect(hello_node.value).to eq('WORLD')
          hellish = subject.search('hell')
          expect(hellish.key).to eq('l')
          expect(hellish.value).to be_nil
          expect(subject.search('greeting')).to be_nil
          hellene_node = subject.search('hellene')
          expect(hellene_node.key).to eq('e')
          expect(hellene_node.value).to eq('GREEK')
          expect(subject.search('hellenes')).to be_nil
        end

        it 'should accept the addition of "synonyms"' do
          subject.add('abd', 'first')
          subject.add('abduce', 'ABDUCE')

          abd_node = subject.search('abd')
          expect(abd_node.value).to eq('first')

          subject.add('abd', 'second')
          expect(abd_node.value).to eq(%w[first second])
        end
      end # context
    end # describe
  end # module
end # module
