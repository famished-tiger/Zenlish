# frozen_string_literal: true

require_relative '../../../lib/zenlish/wclasses/common_noun'
require_relative '../../../lib/zenlish/lex/lexeme'
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/inflect/method_heading'
require_relative '../../../lib/zenlish/inflect/formal_argument'
# Load the class under test
require_relative '../../../lib/zenlish/inflect/matches_pattern'

module Zenlish
  module Inflect
    describe MatchesPattern do
      let(:an_argument) { FormalArgument.new(1) }
      let(:patt) { /[^aeiouy]y$/ }

      subject(:pattern) { described_class.new(an_argument, patt) }

      context 'Initialization:' do
        it 'is initialized with an argument and pattern' do
          expect { described_class.new(an_argument, patt) }.not_to raise_error
        end

        it 'knows its argument' do
          expect(pattern.argument).to eq(an_argument)
        end

        it 'knows the pattern' do
          expect(pattern.pattern).to eq(patt)
        end
      end # context

      context 'Provided services:' do
        it 'checks the actual argument' do
          lexeme = double('dummy-lexeme')
          headings = double('fake-headings')
          actual_args = [nil, 'cherry', nil]
          expect(pattern).to be_success(headings, lexeme, actual_args)
          actual_args[1] = 'boy'
          expect(pattern).not_to be_success(headings, lexeme, actual_args)
          actual_args[1] = 'girl'
          expect(pattern).not_to be_success(headings, lexeme, actual_args)
        end

        it 'tests the lexeme' do
          c_noun = WClasses::CommonNoun.new
          entry = Lex::LexicalEntry.new('cherry')
          lexeme = Lex::Lexeme.new(c_noun, entry)
          headings = [nil, MethodHeading.new('lemma'), nil]
          expect(pattern).to be_success(headings, lexeme, [])

          entry2 = Lex::LexicalEntry.new('boy')
          lexeme2 = Lex::Lexeme.new(c_noun, entry2)
          expect(pattern).not_to be_success(headings, lexeme2, [])

          # instance = EqualsLiteral.new(an_argument, :irregular)
          # expect(instance.success?(headings, lexeme, [])).to be_falsey
        end
      end # context
    end # describe
  end # module
end # module
