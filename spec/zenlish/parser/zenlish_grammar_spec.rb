# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/parser/zenlish_grammar' # Load the class under test

module Zenlish
  module Parser
    describe ZenlishGrammar do
      subject { ZenlishGrammar }

      context 'Initialization:' do
        it 'should know its terminal symbols' do
          expect { subject.name2symbol['CommonNoun'] }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
      end # context
    end # describe
  end # module
end # module