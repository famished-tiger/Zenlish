# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'

# Load the class under test
require_relative '../../../lib/zenlish/wclasses/irregular_verb'

module Zenlish
  module WClasses
    describe IrregularVerb do
      subject(:verb) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        def build_verb(aBaseForm, p_simple, p_participle)
          entry = Zenlish::Lex::LexicalEntry.new(aBaseForm)
          lexeme = Zenlish::Lex::Lexeme.new(verb, entry)
          lexeme.forms past_simple: p_simple, past_participle: p_participle
          lexeme
        end

        def test_inflection_of(verb_form, p_simple, p_participle, pairs)
          verb = build_verb(verb_form, p_simple, p_participle)
          pairs.each do |(constraints, expected_form)|
            expect(verb.inflect(constraints)).to eq(expected_form)
          end
        end

        def test_all_inflections(verb_form, p_simple, p_participle, wforms)
          verb = build_verb(verb_form, p_simple, p_participle)
          inflected = verb.all_inflections
          expect(inflected.sort).to eq(wforms.sort)
        end

        let(:present_1sg) { [:first, :singular, :present, nil] }
        let(:present_3sg) { [:third, :singular, :present, nil] }
        let(:present_1pl) { [:first, :plural,   :present, nil] }
        let(:progressive) { [nil,    nil,       :progressive, nil] }
        let(:past_simple) { [nil,    nil,       :past_simple, nil] }
        let(:past_participle) { [nil, nil,      :past_participle, nil] }

        it 'knows its inherited feature definitions' do
          expect(verb['NUMBER']).to be_a(Feature::FeatureDef)
          expect(verb['PERSON']).to be_a(Feature::FeatureDef)
          expect(verb['PARADIGM'].default.val).to eq('Irregular_inflection')
        end

        it 'knows how to inflect irregular verbs' do
          expectations1 = [
            [present_1sg,     'see'],
            [present_3sg,     'sees'],
            [present_1pl,     'see'],
            [progressive,     'seeing'],
            [past_simple,     'saw'],
            [past_participle, 'seen']
          ]
          test_inflection_of('see', 'saw', 'seen', expectations1)

          expectations2 = [
            [present_1sg, 'make'],
            [present_3sg, 'makes'],
            [present_1pl, 'make'],
            [progressive, 'making'],
            [past_simple, 'made'],
            [past_participle, 'made']
          ]
          test_inflection_of('make', 'made', 'made', expectations2)
        end

        it 'gives all word forms of a given verb' do
          test_all_inflections('see', 'saw', 'seen', %w[see sees seeing saw seen])
        end
      end # context
    end # describe
  end # module
end # module
