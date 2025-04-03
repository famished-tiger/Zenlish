# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'

# Load the class under test
require_relative '../../../lib/zenlish/wclasses/regular_verb_want'

module Zenlish
  module WClasses
    describe RegularVerbWant do
      subject(:the_verb) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'knows its inherited feature definitions' do
          expect(the_verb['NUMBER']).to be_a(Feature::FeatureDef)
          expect(the_verb['PERSON']).to be_a(Feature::FeatureDef)
          expect(the_verb['PARADIGM'].default.val).to eq('Regular_inflection')
        end
      end # context
    end # describe
  end # module
end # module
