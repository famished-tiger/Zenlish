# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/feature/enumeration_domain' 

module Zenlish
  module Feature
    describe EnumerationDomain do
      subject { EnumerationDomain.new(:singular, :plural) }

      context 'Initialization:' do
        it 'should be initialized with arguments' do
          expect { EnumerationDomain.new(:singular, :plural) }.not_to raise_error
        end
        
        it 'should know the values of enumeration' do
          expect(subject.enum).to eq([:singular, :plural])
        end
      end # context

      context 'Provided services:' do
        it 'should know whether a value is in domain' do
          expect(subject.include?(:dual)).to be_falsey
          expect(subject.include?(:singular)).to be_truthy
          expect(subject.include?(:plural)).to be_truthy
        end
        
        it 'should provide a factory method for enumerated value' do
          expect(subject.build_value(:plural)).to be_kind_of(SymbolValue)
          value = subject.build_value(:plural)
          expect(value.val).to eq(:plural)
        end

        it 'should complain when asked to build a non-member value' do
          err = StandardError
          err_msg = "dual isn't part of enumeration [singular, plural]."
          expect { subject.build_value(:dual) }.to raise_error(err, err_msg)
        end      
      end # context
    end # describe
  end # module
end # module
