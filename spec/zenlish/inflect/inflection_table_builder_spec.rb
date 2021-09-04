# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/inflect/inflection_table_builder'

module Zenlish
  module Inflect
    # rubocop: disable Layout/SpaceInsideParens
    # rubocop: disable Naming/VariableNumber

    describe InflectionTableBuilder do
      subject { InflectionTableBuilder.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { InflectionTableBuilder.new }.not_to raise_error
        end

        it 'should not have headings after initialization' do
          expect(subject.headings).to be_empty
        end
      end # context

      context 'Basic services:' do
        it 'should retain the table name' do
          subject.build('Common_form')
          expect(subject.table.name).to eq('Common_form')
        end

        it 'should accept heading creation' do
          # First way
          subject.feature_heading 'NUMBER'
          expect(subject.headings.size).to eq(1)
          expect(subject.headings.last.label).to eq('NUMBER')
          subject.method_heading 'base_form'
          expect(subject.headings.last).to be_kind_of(MethodHeading)
          expect(subject.headings.last.label).to eq('base_form')

          # Second way
          table = subject.build('Common_form') do
            feature_heading 'NUMBER'
            method_heading 'base_form'
          end
          expect(table.name).to eq('Common_form')
          expect(table.headings.last.label).to eq('base_form')
        end
      end # context

      context 'Table building:' do
        it 'should be able to build consequents' do
          table = subject.build('Common_form') do
            feature_heading 'NUMBER'
            method_heading 'base_form'
            rule([], col('base_form'))
            rule([], sub(col('base_form'), /y$/, 'ies'))
            rule([], concat(col('base_form'), 's'))
          end
          expect(table.rules).not_to be_empty
          consequent_0 = table.rules[0].consequent
          expect(consequent_0).to be_kind_of(InputAsIs)
          expect(consequent_0.formal.index).to eq(1)

          consequent_1 = table.rules[1].consequent
          expect(consequent_1).to be_kind_of(Substitution)
          expect(consequent_1.children[0].formal.index).to eq(1)
          expect(consequent_1.pattern).to eq(/y$/)
          expect(consequent_1.children[-1].text).to eq('ies')

          consequent_2 = table.rules[2].consequent
          expect(consequent_2.children[0].formal.index).to eq(1)
          expect(consequent_2).to be_kind_of(Concatenation)
          expect(consequent_2.children[-1].text).to eq('s')
        end

        it 'should be able to build conditions' do
          table = subject.build('Common_form') do
            feature_heading 'NUMBER'
            method_heading 'base_form'
            rule([equals(:singular), dont_care], col('base_form'))
            rule([equals(:plural), matches(/[^aeiouy]y$/)], sub(col('base_form'), /y$/, 'ies'))
            rule([equals(:plural), dont_care], concat(col('base_form'), 's'))
          end

          conds_0 = table.rules[0].conditions
          expect(conds_0[0]).to be_kind_of(EqualsLiteral)
          expect(conds_0[0].literal).to eq(:singular)
          expect(conds_0[1]).to be_kind_of(UnconditionallyTrue)

          conds_1 = table.rules[1].conditions
          expect(conds_1[0]).to be_kind_of(EqualsLiteral)
          expect(conds_1[0].literal).to eq(:plural)
          expect(conds_1[1]).to be_kind_of(MatchesPattern)
          expect(conds_1[1].pattern).to eq(/[^aeiouy]y$/)

          conds_2 = table.rules[2].conditions
          expect(conds_2[0]).to be_kind_of(EqualsLiteral)
          expect(conds_2[0].literal).to eq(:plural)
          expect(conds_2[1]).to be_kind_of(UnconditionallyTrue)
        end

        let(:mock_feature_bearer) { Struct.new(:NUMBER, :base_form) }

        it 'should build default paradigm for common nouns' do
          table = subject.build('Common_form') do
            feature_heading 'NUMBER'
            method_heading 'base_form'
            rule([equals(:singular), dont_care], col('base_form'))
            rule([equals(:plural), matches(/[^aeiouy]y$/)], sub(col('base_form'), /y$/, 'ies'))
            rule([equals(:plural), dont_care], concat(col('base_form'), 's'))
          end

          mck_1 = mock_feature_bearer.new(:singular, 'animal')
          expect(table.inflect(mck_1, [nil, nil])).to eq('animal')
          mck_1['NUMBER'] = :plural
          expect(table.inflect(mck_1, [nil, nil])).to eq('animals')

          mck_2 = mock_feature_bearer.new(:singular, 'boy')
          expect(table.inflect(mck_2, [nil, nil])).to eq('boy')
          mck_2['NUMBER'] = :plural
          expect(table.inflect(mck_2, [nil, nil])).to eq('boys')

          mck_3 = mock_feature_bearer.new(:singular, 'body')
          expect(table.inflect(mck_3, [nil, nil])).to eq('body')
          mck_3['NUMBER'] = :plural
          expect(table.inflect(mck_3, [nil, nil])).to eq('bodies')
        end

        MockRegularVerb = Struct.new(:base_form, :PERSON, :NUMBER, :TIME)
        it 'should build default paradigm for regular verbs' do
          table = subject.build('Regular_form') do
            feature_heading 'PERSON'
            feature_heading 'NUMBER'
            feature_heading 'TIME'
            method_heading  'base_form'
            #     PERSON             NUMBER             TIME                         base_form
            rule([not_equal(:third), dont_care,         equals(:present),            dont_care], col('base_form'))
            rule([equals(:third),    equals(:singular), equals(:present),            matches(/[^aeiouy]y$/)], sub(col('base_form'), /y$/, 'ies'))
            rule([equals(:third),    equals(:singular), equals(:present),            matches(/(?:[osxz]|ch|sh)$/)], concat(col('base_form'), 'es'))
            rule([equals(:third),    equals(:singular), equals(:present),            dont_care], concat(col('base_form'), 's'))
            rule([dont_care,         dont_care, equals(:progressive),                matches(/e$/)], sub(col('base_form'), /e$/, 'ing'))
            rule([dont_care,         dont_care, equals(:progressive),                dont_care], concat(col('base_form'), 'ing'))
            rule([dont_care,         dont_care, in?(:past_simple, :past_participle), matches(/e$/)], concat(col('base_form'), 'd'))
            rule([dont_care,         dont_care, in?(:past_simple, :past_participle), matches(/[^aeiouy]y$/)], sub(col('base_form'), /y$/, 'ied'))
            rule([dont_care,         dont_care, in?(:past_simple, :past_participle), dont_care], concat(col('base_form'), 'ed'))
          end

          verb_1 = MockRegularVerb.new('belong', :first, :singular, :present)
          expect(table.inflect(verb_1, [nil,    nil,     nil, nil]             )).to eq('belong')
          expect(table.inflect(verb_1, [:third, nil,     nil, nil]             )).to eq('belongs')
          expect(table.inflect(verb_1, [nil,    :plural, nil, nil]             )).to eq('belong')
          expect(table.inflect(verb_1, [nil,    nil,     :progressive, nil]    )).to eq('belonging')
          expect(table.inflect(verb_1, [nil,    nil,     :past_simple, nil]    )).to eq('belonged')
          expect(table.inflect(verb_1, [nil,    nil,     :past_participle, nil])).to eq('belonged')

          verb_2 = MockRegularVerb.new('try', :first, :singular, :present)
          expect(table.inflect(verb_2, [nil,    nil,     nil, nil]             )).to eq('try')
          expect(table.inflect(verb_2, [:third, nil,     nil, nil]             )).to eq('tries')
          expect(table.inflect(verb_2, [nil,    :plural, nil, nil]             )).to eq('try')
          expect(table.inflect(verb_2, [nil,    nil,     :progressive, nil]    )).to eq('trying')
          expect(table.inflect(verb_2, [nil,    nil,     :past_simple, nil]    )).to eq('tried')
          expect(table.inflect(verb_2, [nil,    nil,     :past_participle, nil])).to eq('tried')

          verb_3 = MockRegularVerb.new('touch', :first, :singular, :present)
          expect(table.inflect(verb_3, [:second, nil,    nil, nil]             )).to eq('touch')
          expect(table.inflect(verb_3, [:third, nil,     nil, nil]             )).to eq('touches')
          expect(table.inflect(verb_3, [nil,    :plural, nil, nil]             )).to eq('touch')
          expect(table.inflect(verb_3, [nil,    nil,     :progressive, nil]    )).to eq('touching')
          expect(table.inflect(verb_3, [nil,    nil,     :past_simple, nil]    )).to eq('touched')
          expect(table.inflect(verb_3, [nil,    nil,     :past_participle, nil])).to eq('touched')

          verb_4 = MockRegularVerb.new('cause', :first, :singular, :present)
          expect(table.inflect(verb_4, [nil,    nil,     nil, nil]             )).to eq('cause')
          expect(table.inflect(verb_4, [:third, nil,     nil, nil]             )).to eq('causes')
          expect(table.inflect(verb_4, [nil,    :plural, nil, nil]             )).to eq('cause')
          expect(table.inflect(verb_4, [nil,    nil,     :progressive, nil]    )).to eq('causing')
          expect(table.inflect(verb_4, [nil,    nil,     :past_simple, nil]    )).to eq('caused')
          expect(table.inflect(verb_4, [nil,    nil,     :past_participle, nil])).to eq('caused')
        end

        MockIrregularVerb = Struct.new(:base_form, :PERSON, :NUMBER, :TIME, :past_simple, :past_participle)
        it 'should build default paradigm for irregular verbs' do
          table = subject.build('Irregular_inflection') do
            feature_heading 'PERSON'
            feature_heading 'NUMBER'
            feature_heading 'TIME'
            method_heading  'base_form'
            #     PERSON             NUMBER             TIME                      base_form
            rule([not_equal(:third), dont_care,         equals(:present),         dont_care], col('base_form'))
            rule([equals(:third),    equals(:singular), equals(:present),         matches(/[^aeiouy]y$/)], sub(col('base_form'), /y$/, 'ies'))
            rule([equals(:third),    equals(:singular), equals(:present),         matches(/(?:[osxz]|ch|sh)$/)], concat(col('base_form'), 'es'))
            rule([equals(:third),    equals(:singular), equals(:present),         dont_care], concat(col('base_form'), 's'))
            rule([dont_care,         dont_care,         equals(:progressive),     matches(/e$/)], sub(col('base_form'), /e$/, 'ing'))
            rule([dont_care,         dont_care,         equals(:progressive),     dont_care], concat(col('base_form'), 'ing'))
            rule([dont_care,         dont_care,         equals(:past_simple),     dont_care], func('past_simple'))
            rule([dont_care,         dont_care,         equals(:past_participle), dont_care], func('past_participle'))
          end

          verb_1 = MockIrregularVerb.new('choose', :first, :singular, :present, 'chose', 'chosen')
          expect(table.inflect(verb_1, [nil,    nil,     nil, nil]             )).to eq('choose')
          expect(table.inflect(verb_1, [:third, nil,     nil, nil]             )).to eq('chooses')
          expect(table.inflect(verb_1, [nil,    :plural, nil, nil]             )).to eq('choose')
          expect(table.inflect(verb_1, [nil,    nil,     :progressive, nil]    )).to eq('choosing')
          expect(table.inflect(verb_1, [nil,    nil,     :past_simple, nil]    )).to eq('chose')
          expect(table.inflect(verb_1, [nil,    nil,     :past_participle, nil])).to eq('chosen')
        end
      end # context
    end # describe
    # rubocop: enable Naming/VariableNumber
    # rubocop: enable  Layout/SpaceInsideParens
  end # module
end # module
