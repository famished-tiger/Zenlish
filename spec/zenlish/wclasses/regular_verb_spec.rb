# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'

# Load the class under test
require_relative '../../../lib/zenlish/wclasses/regular_verb'

module Zenlish
  module WClasses
    describe RegularVerb do
      subject { RegularVerb.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { RegularVerb.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'should know its inherited feature definitions' do
          expect(subject['NUMBER']).to be_kind_of(Feature::FeatureDef)
          expect(subject['PERSON']).to be_kind_of(Feature::FeatureDef)
          expect(subject['PARADIGM'].default.val).to eq('Regular_inflection')
        end
        
        let(:present_1sg) { [:first, :singular, :present, nil] }
        let(:present_3sg) { [:third, :singular, :present, nil] }
        let(:present_1pl) { [:first, :plural,   :present, nil] }
        let(:progressive) { [nil,    nil,       :progressive, nil] }
        let(:past_simple) { [nil,    nil,       :past_simple, nil] }
        let(:past_participle) { [nil, nil,      :past_participle, nil] }        
        
        def build_verb(aBaseForm)
          entry = Zenlish::Lex::LexicalEntry.new(aBaseForm)
          lexeme = Zenlish::Lex::Lexeme.new(subject, entry)
        end

        def test_inflection_of(verb_form, pairs)
          verb = build_verb(verb_form)
          pairs.each do |(constraints, expected_form)|
            expect(verb.inflect(constraints)).to eq(expected_form)
          end
        end

        it 'should how to inflect regular verbs' do
          expectations_1 = [
            [present_1sg,     'exist'],
            [present_3sg,     'exists'],
            [present_1pl,     'exist'],
            [progressive,     'existing'],
            [past_simple,     'existed'],
            [past_participle, 'existed']
          ]
          test_inflection_of('exist', expectations_1)

          expectations_2 = [
            [present_1sg, 'move'],
            [present_3sg, 'moves'],
            [present_1pl, 'move'],
            [progressive, 'moving'],
            [past_simple, 'moved'],
            [past_participle, 'moved']
          ]
          test_inflection_of('move', expectations_2)

          expectations_3 = [
            [present_1sg, 'try'],
            [present_3sg, 'tries'],
            [present_1pl, 'try'],
            [progressive, 'trying'],
            [past_simple, 'tried'],
            [past_participle, 'tried']
          ]
          test_inflection_of('try', expectations_3)

          expectations_4 = [
            [present_1sg, 'touch'],
            [present_3sg, 'touches'],
            [present_1pl, 'touch'],
            [progressive, 'touching'],
            [past_simple, 'touched'],
            [past_participle, 'touched']
          ]
          test_inflection_of('touch', expectations_4)          
        end
      end # context
    end # describe
  end # module
end # module