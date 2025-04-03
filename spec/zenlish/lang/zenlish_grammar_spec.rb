# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lang/zenlish_grammar' # Load the class under test

module Zenlish
  module Lang
    describe ZenlishGrammar do
      subject(:grammar) { described_class }

      context 'Initialization:' do
        it 'knows its terminal symbols' do
          expect { grammar.name2symbol['CommonNoun'] }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
      end # context
    end # describe
  end # module
end # module
