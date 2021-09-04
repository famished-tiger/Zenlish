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
      subject { InputAsIs.new(sample_argument) }

      context 'Initialization:' do
        it 'should be initialized with a formal rgument' do
          expect { InputAsIs.new(sample_argument) }.not_to raise_error
        end

        it 'should know its text value' do
          expect(subject.formal).to eq(sample_argument)
        end
      end # context

      context 'Provided services:' do
        it 'should return the text of given argument during generation' do
          lexeme = double('fake-lexeme')
          headings = double('fake-headings')
          expect(subject.generate(headings, lexeme, sample_values)).to eq('Hello, world.')
        end

        it 'should return the text of given lexeme during generation' do
          c_noun = WClasses::CommonNoun.new
          an_entry = Lex::LexicalEntry.new('cherry')
          lexeme = Lex::Lexeme.new(c_noun, an_entry)
          heading = MethodHeading.new('base_form')
          headings = [nil, nil, heading, nil]
          expect(subject.generate(headings, lexeme, [])).to eq('cherry')
        end
      end # context
    end # describe
  end # module
end # module
