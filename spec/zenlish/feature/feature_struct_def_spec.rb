# frozen_string_literal: true

require_relative '../../../lib/zenlish/feature/boolean_domain'
require_relative '../../../lib/zenlish/feature/enumeration_domain'
require_relative '../../../lib/zenlish/feature/feature_def'
# Load the class under test
require_relative '../../../lib/zenlish/feature/feature_struct_def'


module Zenlish
  module Feature
    describe FeatureStructDef do
      let(:enum_number) { EnumerationDomain.new(:singular, :plural) }
      let(:ft_number) { FeatureDef.new('NUMBER', enum_number) }
      let(:countable_domain) { BooleanDomain.instance }
      let(:ft_countability) { FeatureDef.new('COUNTABILITY', countable_domain) }
      let(:sample_parent) { described_class.new }
      let(:case_domain) { EnumerationDomain.new(:common, :genitive) }
      let(:ft_case) { FeatureDef.new('CASE', case_domain) }

      subject(:struct_def) { described_class.new(sample_parent) }

      context 'Initialization:' do
        it 'can be initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end

        it 'can be initialized with a parent struct' do
          expect { described_class.new(sample_parent) }.not_to raise_error
        end

        it 'has an empty structure at initialization' do
          expect(struct_def.struct).to be_empty
        end

        it 'knows its parent (if any)' do
          expect(struct_def.parent).to eq(sample_parent)
          instance = described_class.new
          expect(instance.parent).to be_nil
        end
      end # context

      context 'Provided services:' do
        it 'accepts the addition of a feature definition' do
          expect { struct_def.add_feature_def(ft_number) }.not_to raise_error
          expect(struct_def.struct.size).to eq(1)
          expect(struct_def['NUMBER']).to eq(ft_number)

          expect { struct_def.add_feature_def(ft_countability) }.not_to raise_error
          expect(struct_def.struct.size).to eq(2)
          expect(struct_def['COUNTABILITY']).to eq(ft_countability)
        end

        it 'inherits the feature definition of its parent' do
          sample_parent.add_feature_def(ft_case)
          expect(struct_def['CASE']).to eq(ft_case)
        end

        it "is able to override parent's feature def" do
          sample_parent.add_feature_def(ft_case)

          other_case_domain = BooleanDomain.instance
          other_ft_case = FeatureDef.new('CASE', other_case_domain)
          struct_def.add_feature_def(other_ft_case)
          expect(struct_def['CASE']).to eq(other_ft_case)
        end
      end # context
    end # describe
  end # module
end # module
