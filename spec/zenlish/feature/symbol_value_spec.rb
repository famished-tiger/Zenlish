# frozen_string_literal: true

require_relative '../../../lib/zenlish/feature/enumeration_domain'
# Load the class under test
require_relative '../../../lib/zenlish/feature/symbol_value'

module Zenlish
  module Feature
    describe SymbolValue do
      let(:its_value) { :plural }

      subject(:symbolic) { described_class.new(its_value) }

      context 'Initialization:' do
        it 'is initialized with a value argument' do
          expect { described_class.new(its_value) }.not_to raise_error
        end

        it 'knows its internal value' do
          expect(symbolic.val).to eq(its_value)
        end
      end # context

      context 'Provided services:' do
      end # context
    end # describe
  end # module
end # module
