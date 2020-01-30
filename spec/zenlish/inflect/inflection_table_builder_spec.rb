# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/inflect/inflection_table_builder'

module Zenlish
  module Inflect
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

        MockFeatureBearer = Struct.new(:NUMBER, :base_form)

        it 'should build tables conform to specs' do
          table = subject.build('Common_form') do
            feature_heading 'NUMBER'
            method_heading 'base_form'
            rule([equals(:singular), dont_care], col('base_form'))
            rule([equals(:plural), matches(/[^aeiouy]y$/)], sub(col('base_form'), /y$/, 'ies'))
            rule([equals(:plural), dont_care], concat(col('base_form'), 's'))
          end

          mck_1 = MockFeatureBearer.new(:singular, 'animal')
          expect(table.inflect(mck_1, [nil, nil])).to eq('animal')
          mck_1['NUMBER'] = :plural
          expect(table.inflect(mck_1, [nil, nil])).to eq('animals')

          mck_2 = MockFeatureBearer.new(:singular, 'boy')
          expect(table.inflect(mck_2, [nil, nil])).to eq('boy')
          mck_2['NUMBER'] = :plural
          expect(table.inflect(mck_2, [nil, nil])).to eq('boys')

          mck_3 = MockFeatureBearer.new(:singular, 'body')
          expect(table.inflect(mck_3, [nil, nil])).to eq('body')
          mck_3['NUMBER'] = :plural
          expect(table.inflect(mck_3, [nil, nil])).to eq('bodies')
        end
      end # context
    end # describe
  end # module
end # module