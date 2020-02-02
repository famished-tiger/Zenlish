# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework

# Load the class under test
require_relative '../../../lib/zenlish/wclasses/lexical_verb' 

module Zenlish
  module WClasses
    describe LexicalVerb do
      subject { LexicalVerb.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { LexicalVerb.new }.not_to raise_error
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
