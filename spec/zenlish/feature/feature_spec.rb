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

      subject { Feature.new(feat_def) }

      context 'Initialization:' do
        it 'should be initialized with one definition argument' do
          expect { Feature.new(feat_def) }.not_to raise_error
        end

        it 'should know its definition' do
          expect(subject.definition).to eq(feat_def)
        end

        it "should'nt be bound yet to a value" do
          expect(subject.binding).to be_nil
          expect(subject).not_to be_bound
        end
      end # context

      context 'Provided services:' do
        it "should know the definition's name" do
          expect(subject.name).to eq(feat_def.name)
        end

        it "should know the domain of its values" do
          expect(subject.domain).to eq(a_domain)
        end

        it 'should accept a value binding' do
          expect { subject.bind_to(plural_value) }.not_to raise_error
          expect(subject).to be_bound
           expect(subject.binding).to eq(plural_value)
        end
      end # context
    end # describe
  end # module
end # module