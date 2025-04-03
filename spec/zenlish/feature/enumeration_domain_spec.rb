# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/feature/enumeration_domain'

module Zenlish
  module Feature
    describe EnumerationDomain do
      subject(:enumeration) { described_class.new(:singular, :plural) }

      context 'Initialization:' do
        it 'is initialized with arguments' do
          expect { described_class.new(:singular, :plural) }.not_to raise_error
        end

        it 'knows the values of enumeration' do
          expect(enumeration.enum).to eq(%i[singular plural])
        end
      end # context

      context 'Provided services:' do
        it 'knows whether a value is in domain' do
          expect(enumeration).not_to include(:dual)
          expect(enumeration).to include(:singular)
          expect(enumeration).to include(:plural)
        end

        it 'provides a factory method for enumerated value' do
          expect(enumeration.build_value(:plural)).to be_a(SymbolValue)
          value = enumeration.build_value(:plural)
          expect(value.val).to eq(:plural)
        end

        it 'returns all valid values in domain when requested' do
          expect(enumeration.to_a).to eq(%i[singular plural])
        end

        it 'complains when asked to build a non-member value' do
          err = StandardError
          err_msg = "dual isn't part of enumeration [singular, plural]."
          expect { enumeration.build_value(:dual) }.to raise_error(err, err_msg)
        end
      end # context
    end # describe
  end # module
end # module
