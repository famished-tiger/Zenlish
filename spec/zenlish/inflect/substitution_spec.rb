# frozen_string_literal: true

require_relative '../../../lib/zenlish/inflect/formal_argument'
require_relative '../../../lib/zenlish/inflect/input_asis'
# Load the class under test
require_relative '../../../lib/zenlish/inflect/substitution'

module Zenlish
  module Inflect
    describe Substitution do
      let(:suffix) { LiteralAsIs.new('ies') }
      let(:sample_argument) { FormalArgument.new(1) }
      let(:base) { InputAsIs.new(sample_argument) }
      let(:pattern) { /y$/ }

      subject(:substitution) { described_class.new(base, pattern, suffix) }

      context 'Initialization:' do
        it 'is initialized with two arguments' do
          expect { described_class.new(base, pattern, suffix) }.not_to raise_error
        end

        it 'knows its arguments' do
          expect(substitution.children.first).to eq(base)
          expect(substitution.children[1]).to eq(pattern)
          expect(substitution.children.last).to eq(suffix)
        end
      end # context

      context 'Provided services:' do
        let(:sample_heading) { double('fake-headings') }
        let(:sample_values) { [nil, 'cherry', nil] }

        it 'concatenates children results' do
          lexeme = double('fake-lexeme')

          expect(substitution.generate(sample_heading, lexeme, sample_values)).to eq('cherries')
        end
      end # context
    end # describe
  end # module
end # module
