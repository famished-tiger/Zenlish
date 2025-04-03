# frozen_string_literal: true

require_relative '../../../lib/zenlish/wclasses/common_noun'
require_relative '../../../lib/zenlish/lex/lexeme'
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/inflect/method_heading'
require_relative '../../../lib/zenlish/inflect/formal_argument'
# Load the class under test
require_relative '../../../lib/zenlish/inflect/input_asis'

module Zenlish
  module Inflect
    describe InputAsIs do
      let(:sample_argument) { FormalArgument.new(2) }
      let(:sample_values) { [nil, nil, 'Hello, world.', nil] }

      subject(:input) { described_class.new(sample_argument) }

      context 'Initialization:' do
        it 'is initialized with a formal rgument' do
          expect { described_class.new(sample_argument) }.not_to raise_error
        end

        it 'knows its text value' do
          expect(input.formal).to eq(sample_argument)
        end
      end # context

      context 'Provided services:' do
        it 'returns the text of given argument during generation' do
          lexeme = double('fake-lexeme')
          headings = double('fake-headings')
          expect(input.generate(headings, lexeme, sample_values)).to eq('Hello, world.')
        end

        it 'returns the text of given lexeme during generation' do
          c_noun = WClasses::CommonNoun.new
          an_entry = Lex::LexicalEntry.new('cherry')
          lexeme = Lex::Lexeme.new(c_noun, an_entry)
          heading = MethodHeading.new('base_form')
          headings = [nil, nil, heading, nil]
          expect(input.generate(headings, lexeme, [])).to eq('cherry')
        end
      end # context
    end # describe
  end # module
end # module
