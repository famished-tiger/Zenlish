# frozen_string_literal: true

require_relative '../../../lib/zenlish/inflect/formal_argument'
require_relative '../../../lib/zenlish/inflect/input_asis'
# Load the class under test
require_relative '../../../lib/zenlish/inflect/concatenation'

module Zenlish
  module Inflect
    describe Concatenation do
      let(:suffix) { LiteralAsIs.new('s') }
      let(:sample_argument) { FormalArgument.new(2) }
      let(:base_form) { InputAsIs.new(sample_argument) }

      subject { Concatenation.new(base_form, suffix) }

      context 'Initialization:' do
        it 'should be initialized with two arguments' do
          expect { Concatenation.new(base_form, suffix) }.not_to raise_error
        end

        it 'should know its arguments' do
          expect(subject.children.first).to eq(base_form)
          expect(subject.children.last).to eq(suffix)
        end
      end # context

      context 'Provided services:' do
        let(:sample_values) { [nil, nil, 'place', nil] }

        it 'should do the concatenation of children results' do
          headings = double('fake-headings')
          lexeme = double('fake-lexeme')

          expect(subject.generate(headings, lexeme, sample_values)).to eq('places')
        end
      end # context
    end # describe
  end # module
end # module
