# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/inflect/literal_asis'

module Zenlish
  module Inflect
    describe LiteralAsIs do
      subject { LiteralAsIs.new('s') }

      context 'Initialization:' do
        it 'should be initialized with a text literal' do
          expect { LiteralAsIs.new('s') }.not_to raise_error
        end
        
        it 'should know its text value' do
          expect(subject.text).to eq('s')
        end
      end # context

      context 'Provided services:' do
        it 'should return the affix during word form generation' do
          headings = double('fake-headings')        
          lexeme = double('fake-lexeme')
          values = double('fake-values')
          expect(subject.generate(headings, lexeme, values)).to eq('s')
        end
      end # context
    end # describe
  end # module
end # module