# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/inflect/feature_heading'

module Zenlish
  module Inflect
    describe FeatureHeading do
      let(:feature_name) { 'NUMBER' }

      subject(:ft_heading) { described_class.new(feature_name) }

      context 'Initialization:' do
        it 'is initialized with a feature name' do
          expect { described_class.new(feature_name) }.not_to raise_error
        end

        it 'knows its label' do
          expect(ft_heading.label).to eq(feature_name)
        end
      end # context

      context 'Provided services:' do
        let(:a_domain) { Feature::EnumerationDomain.new(:singular, :plural) }
        let(:enum_def) { Feature::FeatureDef.new(feature_name, a_domain) }
        let(:b_domain) { Feature::BooleanDomain.instance }
        let(:bool_def) { Feature::FeatureDef.new(feature_name, b_domain) }

        it 'obtains the value of a feature' do
          mocked = { 'NUMBER' => :plural }
          expect(ft_heading.evaluate_for(mocked)).to eq(:plural)
        end

        it 'obtains all possible values of a feature' do
          mocked = { 'NUMBER' => :plural }
          expect(ft_heading.all_matches(mocked)).to eq([:plural])
        end

        it 'obtains all possible values of a enumeration domain' do
          mocked = { 'NUMBER' => enum_def }
          expect(ft_heading.all_matches(mocked)).to eq(%i[singular plural])
        end

        it 'obtains all possible values of a enumeration domain' do
          mocked = { 'NUMBER' => bool_def }
          expect(ft_heading.all_matches(mocked)).to eq([false, true])
        end
      end # context
    end # describe
  end # module
end # module
