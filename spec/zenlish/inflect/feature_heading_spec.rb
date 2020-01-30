# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/inflect/feature_heading'

module Zenlish
  module Inflect
    describe FeatureHeading do
      let(:feature_name) { 'NUMBER' }
      subject { FeatureHeading.new(feature_name) }

      context 'Initialization:' do
        it 'should be initialized with a feature name' do
          expect { FeatureHeading.new(feature_name) }.not_to raise_error
        end
        
        it 'should know its label' do
          expect(subject.label).to eq(feature_name)
        end
      end # context

      context 'Provided services:' do
        it 'should obtain the feature value from a word' do
          mocked = { 'NUMBER' => :plural }
          expect(subject.evaluate_for(mocked)).to eq(:plural)
        end
      end # context
    end # describe
  end # module
end # module