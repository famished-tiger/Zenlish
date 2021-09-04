# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'

# Load the class under test
require_relative '../../../lib/zenlish/wclasses/regular_verb_want'

module Zenlish
  module WClasses
    describe RegularVerbWant do
      subject { RegularVerbWant.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { RegularVerbWant.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'should know its inherited feature definitions' do
          expect(subject['NUMBER']).to be_kind_of(Feature::FeatureDef)
          expect(subject['PERSON']).to be_kind_of(Feature::FeatureDef)
          expect(subject['PARADIGM'].default.val).to eq('Regular_inflection')
        end
      end # context
    end # describe
  end # module
end # module
