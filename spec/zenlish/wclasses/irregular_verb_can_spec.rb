# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'

# Load the class under test
require_relative '../../../lib/zenlish/wclasses/irregular_verb_can'

module Zenlish
  module WClasses
    describe IrregularVerbCan do
      subject { IrregularVerbCan.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { IrregularVerbCan.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'should know its inherited feature definitions' do
          expect(subject['NUMBER']).to be_kind_of(Feature::FeatureDef)
          expect(subject['PERSON']).to be_kind_of(Feature::FeatureDef)
          expect(subject['PARADIGM'].default.val).to eq('Verb_can_inflection')
        end

        def build_verb(aBaseForm)
          entry = Zenlish::Lex::LexicalEntry.new(aBaseForm)
          lexeme = Zenlish::Lex::Lexeme.new(subject, entry)
        end

        def test_inflection_of(verb_form, pairs)
          verb = build_verb(verb_form)
          pairs.each do |(time, expected_form)|
            expect(verb.inflect([time])).to eq(expected_form)
          end
        end

        it 'should know how to inflect modal verb can' do
          expectations_1 = [
            [:present,     'can'],
            [:past_simple, 'could']
          ]
          test_inflection_of('can', expectations_1)
        end
      end # context
    end # describe
  end # module
end # module