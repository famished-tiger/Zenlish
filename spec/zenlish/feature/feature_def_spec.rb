# frozen_string_literal: true

require_relative '../../../lib/zenlish/feature/enumeration_domain'
# Load the class under test
require_relative '../../../lib/zenlish/feature/feature_def'

module Zenlish
  module Feature
    describe FeatureDef do
      let(:a_name) { 'NUMBER' }
      let(:a_domain) { EnumerationDomain.new(:singular, :plural) }
      subject { FeatureDef.new(a_name, a_domain) }

      context 'Initialization:' do
        it 'should be initialized with at least two arguments' do
          expect { FeatureDef.new(a_name, a_domain) }.not_to raise_error
        end

        it 'could be initialized with a default value argument' do
          deflt = double('dummy')
          expect { FeatureDef.new(a_name, a_domain, deflt) }.not_to raise_error
        end

        it 'should know its name' do
          expect(subject.name).to eq(a_name)
        end

        it 'should know the domain of its values' do
          expect(subject.domain).to eq(a_domain)
        end

        it 'should know the domain of its default value' do
          expect(subject.default).to be_nil
          deflt = double('dummy')
          instance = FeatureDef.new(a_name, a_domain, deflt)
          expect(instance.default).to eq(deflt)
        end

        it 'should guess its default if enumeration has a single member' do
          basic_domain = EnumerationDomain.new(:plural)
          instance = FeatureDef.new(a_name, basic_domain)
          expect(instance.default.val).to eq(:plural)
        end
      end # context

      context 'Provided services:' do
      end # context
    end # describe
  end # module
end # module
