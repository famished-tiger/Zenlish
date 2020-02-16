# frozen_string_literal: true

require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'
require_relative '../../../lib/zenlish/wclasses/common_noun'
require_relative '../../../lib/zenlish/inflect/feature_heading'
require_relative '../../../lib/zenlish/inflect/method_heading'
require_relative '../../../lib/zenlish/inflect/unconditionally_true'
require_relative '../../../lib/zenlish/inflect/literal_asis'
require_relative '../../../lib/zenlish/inflect/input_asis'
require_relative '../../../lib/zenlish/inflect/equals_literal'
require_relative '../../../lib/zenlish/inflect/formal_argument'
require_relative '../../../lib/zenlish/inflect/matches_pattern'
require_relative '../../../lib/zenlish/inflect/concatenation'
require_relative '../../../lib/zenlish/inflect/substitution'
require_relative '../../../lib/zenlish/inflect/inflection_rule'
# Load the class under test
require_relative '../../../lib/zenlish/inflect/inflection_table'

module Zenlish
  module Inflect
    describe InflectionTable do
      let(:table_name) { 'Common_form' }
      subject { InflectionTable.new(table_name) }

      context 'Initialization:' do
        it 'should be initialized with a name' do
          expect { InflectionTable.new(table_name) }.not_to raise_error
        end

        it 'should now its name' do
          expect(subject.name).to eq(table_name)
        end

        it 'should not have headings at start' do
          expect(subject.headings).to be_empty
        end

        it 'should not have rules at start' do
          expect(subject.rules).to be_empty
        end
      end # context      

      context 'Provided services:' do
        # DecisionTable: Common_form
        # | NUMBER   | .base_form      | Common_form                |
        # | singular | X               | base_form                  |
        # | plural   | ~ /[^aeiouy]y$/ | sub(base_form, /y$/, "ies")|
        # | plural   | X               | base_form + "s"            |
        let(:feature_name) { 'NUMBER' }
        let(:heading0) { FeatureHeading.new(feature_name) }
        let(:method_name) { 'base_form' }
        let(:heading1) { MethodHeading.new(method_name) }
        let(:arg_0) { FormalArgument.new(0) }
        let(:arg_1) { FormalArgument.new(1) }
        let(:feat_val_a) { :singular }
        let(:feat_val_b) { :plural }
        let(:feat_val_c) { :plural }
        let(:cond_a_0) { EqualsLiteral.new(arg_0, feat_val_a) }
        let(:cond_b_0) { EqualsLiteral.new(arg_0, feat_val_b) }
        let(:cond_c_0) { EqualsLiteral.new(arg_0, feat_val_c) }
        let(:cond_a_1) { UnconditionallyTrue.new }
        let(:patt_b_1) { /[^aeiouy]y$/ }
        let(:cond_b_1) { MatchesPattern.new(arg_1, patt_b_1) }
        let(:cond_c_1) { UnconditionallyTrue.new }
        let(:cons_a) { InputAsIs.new(arg_1) }
        let(:cons_b_arg) { InputAsIs.new(arg_1) }
        let(:patt_b_2) { /y$/ }
        let(:suffix_b) { LiteralAsIs.new('ies') }
        let(:cons_b) { Substitution.new(cons_b_arg, patt_b_2, suffix_b) }
        let(:cons_c_arg) { InputAsIs.new(arg_1) }
        let(:suffix_c) { LiteralAsIs.new('s') }
        let(:cons_c) { Concatenation.new(cons_c_arg, suffix_c) }
        let(:rule_a) { InflectionRule.new([cond_a_0, cond_a_1], cons_a) }
        let(:rule_b) { InflectionRule.new([cond_b_0, cond_b_1], cons_b) }
        let(:rule_c) { InflectionRule.new([cond_c_0, cond_c_1], cons_c) }
        let(:a_wclass) { WClasses::CommonNoun.new }
        let(:a_lemma) { 'body' }
        let(:an_entry) { Lex::LexicalEntry.new(a_lemma) }
        let(:lexm_body) { Lex::Lexeme.new(a_wclass, an_entry) }       
        
        MockFeatureBearer = Struct.new(:NUMBER, :base_form)

        it 'should accept the addition of heading(s)' do
          expect { subject.add_heading(heading0) }.not_to raise_error
          expect(subject.headings.size).to eq(1)
          subject.add_heading(heading1)
          expect(subject.headings.last).to eq(heading1)
        end

        it 'should accept the addition of rule(s)' do
          expect { subject.add_rule(rule_a) }.not_to raise_error
          expect(subject.rules.size).to eq(1)
          subject.add_rule(rule_b)
          expect(subject.rules.last).to eq(rule_b)
          subject.add_rule(rule_c)
          expect(subject.rules.last).to eq(rule_c)
        end
        
        def init_table(aTable)
          aTable.add_heading(heading0)
          aTable.add_heading(heading1)
          aTable.add_rule(rule_a)
          aTable.add_rule(rule_b)
          aTable.add_rule(rule_c)        
        end

        # DecisionTable: Common_form
        # | NUMBER   | .base_form      | Common_form                |
        # | singular | X               | base_form                  |
        # | plural   | ~ /[^aeiouy]y$/ | sub(base_form, /y$/, "ies")|
        # | plural   | X               | base_form + "s"            |
        # inflection_table('Common_form') do
        #   feature_heading 'NUMBER'
        #   method_heading  'base_form'
        #       | NUMBER          | base_form             | Common_form               |
        #   rule(equals(:singular), dont_care             , col(1))
        #   rule(equals(:plural)  , matches(/[^aeiouy]y$/), sub(col(1), /y$/, 'ies'))
        #   rule(equals(:plural)  , dont_care             , concat(col(1), 's'))
        # end
        it 'should determine the word form given input entries' do
          init_table(subject)
          mck_1 = MockFeatureBearer.new(:singular, 'animal')
          expect(subject.inflect(mck_1, [nil, nil])).to eq('animal')
          mck_1['NUMBER'] = :plural
          expect(subject.inflect(mck_1, [nil, nil])).to eq('animals')

          mck_2 = MockFeatureBearer.new(:singular, 'boy')
          expect(subject.inflect(mck_2, [nil, nil])).to eq('boy')
          mck_2['NUMBER'] = :plural
          expect(subject.inflect(mck_2, [nil, nil])).to eq('boys')

          expect(subject.inflect(lexm_body, [:singular, nil])).to eq('body')
          expect(subject.inflect(lexm_body, [:plural, nil])).to eq('bodies')
        end

        it 'should know all the word forms of a given lexeme' do
          init_table(subject)
          expect(subject.all_inflections(lexm_body)).to eq(['body', 'bodies'])
        end
      end # context
    end # describe
  end # module
end # module