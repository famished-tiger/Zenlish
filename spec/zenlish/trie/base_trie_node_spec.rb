# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/trie/base_trie_node' # Load the class under test

module Zenlish
  module Trie
    describe BaseTrieNode do
      subject { BaseTrieNode.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { BaseTrieNode.new }.not_to raise_error
        end

        it 'should be a leaf node at start' do
          expect(subject).to be_leaf
        end
      end # context

      context 'Provided services:' do
        it 'should accept the addition of a successor' do
          some_node = BaseTrieNode.new

          expect(subject.include?('f')).to be_falsy
          expect { subject.add_succ('f', some_node) }.not_to raise_error
          expect(subject.include?('f')).to be_truthy
          expect(subject.succ['f']).to eq(some_node)
        end
      end # context
    end # describe
  end # module
end # module
