# frozen_string_literal: true

require_relative '../../../lib/zenlish/feature/enumeration_domain'
require_relative '../../../lib/zenlish/feature/feature_def'
# Load the class under test
require_relative '../../../lib/zenlish/feature/feature'


module Zenlish
  module Feature
    describe Feature do
      let(:a_name) { 'NUMBER' }
      let(:a_domain) { EnumerationDomain.new(:singular, :plural) }
      let(:feat_def) { FeatureDef.new(a_name, a_domain) }
      let(:plural_value) { a_domain.build_value(:plural) }

      subject(:a_feature) { described_class.new(feat_def) }

      context 'Initialization:' do
        it 'is initialized with one definition argument' do
          expect { described_class.new(feat_def) }.not_to raise_error
        end

        it 'knows its definition' do
          expect(a_feature.definition).to eq(feat_def)
        end

        it "isn't bound yet to a value" do
          expect(a_feature.binding).to be_nil
          expect(a_feature).not_to be_bound
        end
      end # context

      context 'Provided services:' do
        it "knows the definition's name" do
          expect(a_feature.name).to eq(feat_def.name)
        end

        it 'knows the domain of its values' do
          expect(a_feature.domain).to eq(a_domain)
        end

        it 'accepts a value binding' do
          expect { a_feature.bind_to(plural_value) }.not_to raise_error
          expect(a_feature).to be_bound
          expect(a_feature.binding).to eq(plural_value)
        end
      end # context
    end # describe
  end # module
end # module
