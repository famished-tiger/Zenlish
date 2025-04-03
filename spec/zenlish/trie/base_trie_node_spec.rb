# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/trie/base_trie_node' # Load the class under test

module Zenlish
  module Trie
    describe BaseTrieNode do
      subject(:node) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end

        it 'is a leaf node at start' do
          expect(node).to be_leaf
        end
      end # context

      context 'Provided services:' do
        it 'accepts the addition of a successor' do
          some_node = described_class.new

          expect(node).not_to include('f')
          expect { node.add_succ('f', some_node) }.not_to raise_error
          expect(node).to include('f')
          expect(node.succ['f']).to eq(some_node)
        end
      end # context
    end # describe
  end # module
end # module
