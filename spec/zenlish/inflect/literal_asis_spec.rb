# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/inflect/literal_asis'

module Zenlish
  module Inflect
    describe LiteralAsIs do
      subject(:literal) { described_class.new('s') }

      context 'Initialization:' do
        it 'is initialized with a text literal' do
          expect { described_class.new('s') }.not_to raise_error
        end

        it 'knows its text value' do
          expect(literal.text).to eq('s')
        end
      end # context

      context 'Provided services:' do
        it 'returns the affix during word form generation' do
          headings = double('fake-headings')
          lexeme = double('fake-lexeme')
          values = double('fake-values')
          expect(literal.generate(headings, lexeme, values)).to eq('s')
        end
      end # context
    end # describe
  end # module
end # module
