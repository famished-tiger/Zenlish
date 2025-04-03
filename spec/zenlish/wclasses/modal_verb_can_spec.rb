# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'

# Load the class under test
require_relative '../../../lib/zenlish/wclasses/modal_verb_can'

module Zenlish
  module WClasses
    describe ModalVerbCan do
      subject(:modal_can) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'knows its inherited feature definitions' do
          expect(modal_can['NUMBER']).to be_a(Feature::FeatureDef)
          expect(modal_can['PERSON']).to be_a(Feature::FeatureDef)
          expect(modal_can['PARADIGM'].default.val).to eq('Verb_can_inflection')
        end

        def build_verb(aBaseForm)
          entry = Zenlish::Lex::LexicalEntry.new(aBaseForm)
          Zenlish::Lex::Lexeme.new(modal_can, entry)
        end

        def test_inflection_of(verb_form, pairs)
          verb = build_verb(verb_form)
          pairs.each do |(time, expected_form)|
            expect(verb.inflect([time])).to eq(expected_form)
          end
        end

        it 'knows how to inflect modal verb can' do
          expectations1 = [
            [:present,     'can'],
            [:past_simple, 'could']
          ]
          test_inflection_of('can', expectations1)
        end
      end # context
    end # describe
  end # module
end # module
