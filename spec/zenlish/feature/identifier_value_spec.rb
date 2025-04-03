# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/feature/identifier_value'

module Zenlish
  module Feature
    describe IdentifierValue do
      let(:its_value) { 'CommonForm' }

      subject(:identifier) { described_class.new(its_value) }

      context 'Initialization:' do
        it 'is initialized with a value argument' do
          expect { described_class.new(its_value) }.not_to raise_error
        end

        it 'knows its internal value' do
          expect(identifier.val).to eq(its_value)
        end
      end # context

      context 'Provided services:' do
      end # context
    end # describe
  end # module
end # module
