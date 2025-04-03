# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'
require_relative '../../../lib/zenlish/feature/feature_struct_def_bearer'
require_relative '../../../lib/zenlish/wclasses/personal_pronoun' # Load the class under test

module Zenlish
  module WClasses
    describe PersonalPronoun do
      include Feature::FeatureStructDefBearer
      subject(:pronoun) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end

        it 'knows that it is inflectable' do
          expect(pronoun).not_to be_invariable
        end
      end # context

      context 'Provided services:' do
        def build_ppn(aBaseForm, aFeatureHash)
          entry = Zenlish::Lex::LexicalEntry.new(aBaseForm)
          Zenlish::Lex::Lexeme.new(pronoun, entry, aFeatureHash)
        end

        def test_all_inflections(det_form, aFeatureHash, wforms)
          pronoun = build_ppn(det_form, aFeatureHash)
          inflected = pronoun.all_inflections
          expect(inflected.sort).to eq(wforms.sort)
        end

        it 'knows its feature definitions' do
          expect(pronoun['NUMBER']).to be_a(Feature::FeatureDef)
          expect(pronoun['PERSON']).to be_a(Feature::FeatureDef)
          expect(pronoun['GENDER']).to be_a(Feature::FeatureDef)
          expect(pronoun['CASE']).to be_a(Feature::FeatureDef)
          expect(pronoun['PARADIGM'].default.val).to eq('ppn_1st_paradigm')
        end

        it 'gives all word forms for the first person' do
          feature_defs = { 'PERSON' => enumeration(:first),
            'GENDER' => enumeration(:feminine, :masculine) }
          test_all_inflections('I', feature_defs, %w[I we me us])
        end

        it 'gives all word forms for the second person' do
          feature_defs = { 'PERSON' => enumeration(:second),
            'GENDER' => enumeration(:feminine, :masculine),
            'PARADIGM' => [identifier, 'ppn_2nd_paradigm'] }
          test_all_inflections('you', feature_defs, ['you'])
        end

        it 'gives all word forms for the third person' do
          feature_defs = { 'PERSON' => enumeration(:third),
            'PARADIGM' => [identifier, 'ppn_3rd_paradigm'] }
          test_all_inflections('it', feature_defs, %w[she he it they her him them])
        end
      end # context
    end # describe
  end # module
end # module
