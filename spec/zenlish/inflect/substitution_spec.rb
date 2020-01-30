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


      subject { Substitution.new(base, pattern, suffix) }

      context 'Initialization:' do
        it 'should be initialized with two arguments' do
          expect { Substitution.new(base, pattern, suffix) }.not_to raise_error
        end

        it 'should know its arguments' do
          expect(subject.children.first).to eq(base)
          expect(subject.children[1]).to eq(pattern)
          expect(subject.children.last).to eq(suffix)
        end
      end # context

      context 'Provided services:' do
        let(:sample_heading) { double('fake-headings') }
        let(:sample_values) { [nil, 'cherry', nil] }

        it 'should do the concatenation of children results' do
          lexeme = double('fake-lexeme')

          expect(subject.generate(sample_heading, lexeme, sample_values)).to eq('cherries')
        end
      end # context
    end # describe
  end # module
end # module