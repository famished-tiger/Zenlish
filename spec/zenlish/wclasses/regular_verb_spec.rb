# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'

# Load the class under test
require_relative '../../../lib/zenlish/wclasses/regular_verb'

module Zenlish
  module WClasses
    describe RegularVerb do
      subject(:regular_verb) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        let(:present_1sg) { [:first, :singular, :present, nil] }
        let(:present_3sg) { [:third, :singular, :present, nil] }
        let(:present_1pl) { [:first, :plural,   :present, nil] }
        let(:progressive) { [nil,    nil,       :progressive, nil] }
        let(:past_simple) { [nil,    nil,       :past_simple, nil] }
        let(:past_participle) { [nil, nil,      :past_participle, nil] }

        def build_verb(aBaseForm)
          entry = Zenlish::Lex::LexicalEntry.new(aBaseForm)
          Zenlish::Lex::Lexeme.new(regular_verb, entry)
        end

        def test_inflection_of(verb_form, pairs)
          verb = build_verb(verb_form)
          pairs.each do |(constraints, expected_form)|
            expect(verb.inflect(constraints)).to eq(expected_form)
          end
        end

        def test_all_inflections(verb_form, wforms)
          verb = build_verb(verb_form)
          inflected = verb.all_inflections
          expect(inflected.sort).to eq(wforms.sort)
        end

        it 'knows its inherited feature definitions' do
          expect(regular_verb['NUMBER']).to be_a(Feature::FeatureDef)
          expect(regular_verb['PERSON']).to be_a(Feature::FeatureDef)
          expect(regular_verb['PARADIGM'].default.val).to eq('Regular_inflection')
        end

        it 'knows how to inflect regular verbs' do
          expectations1 = [
            [present_1sg,     'exist'],
            [present_3sg,     'exists'],
            [present_1pl,     'exist'],
            [progressive,     'existing'],
            [past_simple,     'existed'],
            [past_participle, 'existed']
          ]
          test_inflection_of('exist', expectations1)

          expectations2 = [
            [present_1sg, 'move'],
            [present_3sg, 'moves'],
            [present_1pl, 'move'],
            [progressive, 'moving'],
            [past_simple, 'moved'],
            [past_participle, 'moved']
          ]
          test_inflection_of('move', expectations2)

          expectations3 = [
            [present_1sg, 'try'],
            [present_3sg, 'tries'],
            [present_1pl, 'try'],
            [progressive, 'trying'],
            [past_simple, 'tried'],
            [past_participle, 'tried']
          ]
          test_inflection_of('try', expectations3)

          expectations4 = [
            [present_1sg, 'touch'],
            [present_3sg, 'touches'],
            [present_1pl, 'touch'],
            [progressive, 'touching'],
            [past_simple, 'touched'],
            [past_participle, 'touched']
          ]
          test_inflection_of('touch', expectations4)

          expectations5 = [
            [present_1sg, 'die'],
            [present_3sg, 'dies'],
            [present_1pl, 'die'],
            [progressive, 'dying'],
            [past_simple, 'died'],
            [past_participle, 'died']
          ]
          test_inflection_of('die', expectations5)

          expectations6 = [
            [present_1sg, 'want'],
            [present_3sg, 'wants'],
            [present_1pl, 'want'],
            [progressive, 'wanting'],
            [past_simple, 'wanted'],
            [past_participle, 'wanted']
          ]
          test_inflection_of('want', expectations6)
        end

        it 'gives all word forms of a given verb' do
          test_all_inflections('die', %w[die dies dying died])
        end
      end # context
    end # describe
  end # module
end # module
