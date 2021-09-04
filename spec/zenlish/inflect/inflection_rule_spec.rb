# frozen_string_literal: true

require_relative '../../../lib/zenlish/wclasses/common_noun'
require_relative '../../../lib/zenlish/lex/lexeme'
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/inflect/feature_heading'
require_relative '../../../lib/zenlish/inflect/method_heading'
require_relative '../../../lib/zenlish/inflect/literal_asis'
require_relative '../../../lib/zenlish/inflect/input_asis'
require_relative '../../../lib/zenlish/inflect/equals_literal'
require_relative '../../../lib/zenlish/inflect/formal_argument'
require_relative '../../../lib/zenlish/inflect/matches_pattern'
require_relative '../../../lib/zenlish/inflect/substitution'

# Load the class under test
require_relative '../../../lib/zenlish/inflect/inflection_rule'

module Zenlish
  module Inflect
    # rubocop: disable Naming/VariableNumber

    describe InflectionRule do
      # One rule in row representation:
      # | plural   | ~ /[^aeiouy]y$/ | sub(base_form, /y$/, "ies")|
      # Heading part
      let(:feature_name) { 'NUMBER' }
      let(:heading0) { FeatureHeading.new(feature_name) }
      let(:method_name) { 'base_form' }
      let(:heading1) { MethodHeading.new(method_name) }
      let(:headings) { [heading0, heading1] }

      # Condition part
      let(:feature_value) { :plural }
      let(:arg_0) { FormalArgument.new(0) }
      let(:cond_0) { EqualsLiteral.new(arg_0, feature_value) }
      let(:arg_1) { FormalArgument.new(1) }
      let(:patt) { /[^aeiouy]y$/ }
      let(:cond_1) { MatchesPattern.new(arg_1, patt) }
      let(:conditions) { [cond_0, cond_1] }

      # Consequent part
      let(:suffix) { LiteralAsIs.new('ies') }
      let(:base) { InputAsIs.new(arg_1) }
      let(:pattern) { /y$/ }
      let(:consequent) { Substitution.new(base, pattern, suffix) }

      subject { InflectionRule.new(conditions, consequent) }

      context 'Initialization:' do
        it 'should be initialized with condition and consequent parts' do
          expect do
            InflectionRule.new(conditions, consequent)
          end.not_to raise_error
        end

        it 'should know its condition part' do
          expect(subject.conditions).to eq(conditions)
        end

        it 'should know its consequent part' do
          expect(subject.consequent).to eq(consequent)
        end
      end # context

      context 'Provided services:' do
        let(:fake_lexeme) { double('dummy-fake_lexeme') }
        let(:c_noun) { WClasses::CommonNoun.new }
        let(:an_entry) { Lex::LexicalEntry.new('cherry') }
        let(:lexeme) { Lex::Lexeme.new(c_noun, an_entry) }

        it 'should succeed when all conditions succeed with actuals' do
          actuals = [:plural, 'cherry']
          expect(subject.success?(headings, fake_lexeme, actuals)).to be_truthy
        end

        it 'should fail when one condition fails with actuals' do
          actuals = [:singular, 'cherry']
          expect(subject.success?(headings, fake_lexeme, actuals)).to be_falsy

          actuals = [:plural, 'girl']
          expect(subject.success?(headings, fake_lexeme, actuals)).to be_falsy
        end

        it 'should generate inflected form when rule iworks for actuals' do
          actuals = [:plural, 'cherry']
          expect(subject.apply(headings, fake_lexeme, actuals)).to eq('cherries')
        end

        it 'should succeed when all conditions succeed for given lexeme' do
          expect(subject.success?(headings, lexeme, [])).to be_truthy
        end

        it 'should fail when one condition fails with given lexeme' do
          entry_2 = Lex::LexicalEntry.new('animal')
          lex_m2 = Lex::Lexeme.new(c_noun, entry_2)
          expect(subject.success?(headings, lex_m2, [])).to be_falsy
        end

        it 'should generate inflected form when rule works for given lexeme' do
          expect(subject.apply(headings, lexeme, [])).to eq('cherries')
        end
      end # context
    end # describe
    # rubocop: enable Naming/VariableNumber
  end # module
end # module
