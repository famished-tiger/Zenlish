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
      let(:sample_parent) { FeatureStructDef.new }
      let(:case_domain) { EnumerationDomain.new(:common, :genitive) }
      let(:ft_case) { FeatureDef.new('CASE', case_domain) }

      subject { FeatureStructDef.new(sample_parent) }

      context 'Initialization:' do
        it 'could be initialized without argument' do
          expect { FeatureStructDef.new }.not_to raise_error
        end

        it 'could be initialized with a parent struct' do
          expect { FeatureStructDef.new(sample_parent) }.not_to raise_error
        end

        it 'should have an empty structure at initialization' do
          expect(subject.struct).to be_empty
        end

        it 'should know its parent (if any)' do
          expect(subject.parent).to eq(sample_parent)
          instance = FeatureStructDef.new
          expect(instance.parent).to be_nil
        end
      end # context

      context 'Provided services:' do
        it 'should accept the addition of a feature definition' do
          expect { subject.add_feature_def(ft_number) }.not_to raise_error
          expect(subject.struct.size).to eq(1)
          expect(subject['NUMBER']).to eq(ft_number)

          expect { subject.add_feature_def(ft_countability) }.not_to raise_error
          expect(subject.struct.size).to eq(2)
          expect(subject['COUNTABILITY']).to eq(ft_countability)
        end

        it 'should inherit the feature definition of its parent' do
          sample_parent.add_feature_def(ft_case)
          expect(subject['CASE']).to eq(ft_case)
        end

        it "should be able to override parent's feature def" do
          sample_parent.add_feature_def(ft_case)

          other_case_domain = BooleanDomain.instance
          other_ft_case = FeatureDef.new('CASE', other_case_domain)
          subject.add_feature_def(other_ft_case)
          expect(subject['CASE']).to eq(other_ft_case)
        end
      end # context
    end # describe
  end # module
end # module
