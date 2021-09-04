# frozen_string_literal: true

require_relative '../../../lib/zenlish/feature/enumeration_domain'
# Load the class under test
require_relative '../../../lib/zenlish/feature/symbol_value'

module Zenlish
  module Feature
    describe SymbolValue do
      let(:its_value) { :plural }
      subject { SymbolValue.new(its_value) }

      context 'Initialization:' do
        it 'should be initialized with a value argument' do
          expect { SymbolValue.new(its_value) }.not_to raise_error
        end

        it 'should know its internal value' do
          expect(subject.val).to eq(its_value)
        end
      end # context

      context 'Provided services:' do
      end # context
    end # describe
  end # module
end # module
