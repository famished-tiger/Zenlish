# frozen_string_literal: true

require_relative '../../../lib/zenlish/wclasses/common_noun'
require_relative '../../../lib/zenlish/lex/lexeme'
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/inflect/feature_heading'
require_relative '../../../lib/zenlish/inflect/formal_argument'
# Load the class under test
require_relative '../../../lib/zenlish/inflect/membership'

module Zenlish
  module Inflect
    describe Membership do
      let(:an_argument) { FormalArgument.new(1) }
      let(:feat_val) { %i[singular plural] }
      subject { Membership.new(an_argument, feat_val) }

      context 'Initialization:' do
        it 'should be initialized with a formal argument and an array' do
          expect { Membership.new(an_argument, feat_val) }.not_to raise_error
        end

        it 'should know its argument' do
          expect(subject.argument).to eq(an_argument)
        end

        it 'should know the array of literals' do
          expect(subject.members).to eq(feat_val)
        end
      end # context

      context 'Provided services:' do
        it 'should test the actual values' do
          lexeme = double('dummy-lexeme')
          headings = double('fake-headings')
          actual_args = [nil, :plural, nil]
          expect(subject.success?(headings, lexeme, actual_args)).to be_truthy
          actual_args[1] = :singular
          expect(subject.success?(headings, lexeme, actual_args)).to be_truthy
          actual_args[1] = :dual
          expect(subject.success?(headings, lexeme, actual_args)).to be_falsy
        end

        # it 'should test the lexeme' do
          # c_noun = WClasses::CommonNoun.new
          # entry = Lex::LexicalEntry.new('animal')
          # lexeme = Lex::Lexeme.new(c_noun, entry)
          # headings = [nil, FeatureHeading.new('NUMBER'), nil]
          # expect(subject.success?(headings, lexeme, [])).to be_truthy

          # instance = Membership.new(an_argument, :singular)
          # expect(instance.success?(headings, lexeme, [])).to be_truthy

          # instance = Membership.new(an_argument, :irregular)
          # expect(instance.success?(headings, lexeme, [])).to be_falsey
        # end
      end # context
    end # describe
  end # module
end # module
