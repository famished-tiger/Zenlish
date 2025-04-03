# frozen_string_literal: true

require_relative '../../../lib/zenlish/wclasses/common_noun'
require_relative '../../../lib/zenlish/lex/lexeme'
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/inflect/feature_heading'
require_relative '../../../lib/zenlish/inflect/formal_argument'
# Load the class under test
require_relative '../../../lib/zenlish/inflect/equals_literal'

module Zenlish
  module Inflect
    describe EqualsLiteral do
      let(:an_argument) { FormalArgument.new(1) }
      let(:feat_val) { :plural }

      subject(:literal) { described_class.new(an_argument, feat_val) }

      context 'Initialization:' do
        it 'is initialized with a formal argument and a literal' do
          expect { described_class.new(an_argument, feat_val) }.not_to raise_error
        end

        it 'knows its argument' do
          expect(literal.argument).to eq(an_argument)
        end

        it 'knows the literal' do
          expect(literal.literal).to eq(feat_val)
        end
      end # context

      context 'Provided services:' do
        it 'tests the actual argument' do
          lexeme = double('dummy-lexeme')
          headings = double('fake-headings')
          actual_args = [nil, :plural, nil]
          expect(literal).to be_success(headings, lexeme, actual_args)
          actual_args[1] = :singular
          expect(literal).not_to be_success(headings, lexeme, actual_args)
        end

        it 'tests the lexeme' do
          c_noun = WClasses::CommonNoun.new
          entry = Lex::LexicalEntry.new('animal')
          lexeme = Lex::Lexeme.new(c_noun, entry)
          headings = [nil, FeatureHeading.new('NUMBER'), nil]
          expect(literal).to be_success(headings, lexeme, [])

          instance = described_class.new(an_argument, :singular)
          expect(instance).to be_success(headings, lexeme, [])

          instance = described_class.new(an_argument, :irregular)
          expect(instance).not_to be_success(headings, lexeme, [])
        end
      end # context
    end # describe
  end # module
end # module
