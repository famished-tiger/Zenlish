# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'
require_relative '../../../lib/zenlish/feature/feature_struct_def_bearer'
require_relative '../../../lib/zenlish/wclasses/possessive_determiner' # Load the class under test

module Zenlish
  module WClasses
    describe PossessiveDeterminer do
      include Feature::FeatureStructDefBearer
      subject(:determiner) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        def build_det(aBaseForm, aFeatureHash)
          entry = Zenlish::Lex::LexicalEntry.new(aBaseForm)
          Zenlish::Lex::Lexeme.new(determiner, entry, aFeatureHash)
        end

        def test_all_inflections(det_form, aFeatureHash, wforms)
          pronoun = build_det(det_form, aFeatureHash)
          inflected = pronoun.all_inflections
          expect(inflected.sort).to eq(wforms.sort)
        end

        it 'knows that it is inflectable' do
          expect(determiner).not_to be_invariable
        end

        it 'knows its feature definitions' do
          expect(determiner['NUMBER']).to be_a(Feature::FeatureDef)
          expect(determiner['PERSON']).to be_a(Feature::FeatureDef)
          expect(determiner['GENDER']).to be_a(Feature::FeatureDef)
          expect(determiner['PARADIGM'].default.val).to eq('possdet_1st_paradigm')
        end

        it 'gives all word forms for the first person' do
          feature_defs = { 'PERSON' => enumeration(:first),
            'GENDER' => enumeration(:feminine, :masculine) }
          test_all_inflections('my', feature_defs, %w[my our])
        end

        it 'gives all word forms for the second person' do
          feature_defs = { 'PERSON' => enumeration(:second),
            'GENDER' => enumeration(:feminine, :masculine),
            'PARADIGM' => [identifier, 'possdet_2nd_paradigm'] }
          test_all_inflections('your', feature_defs, ['your'])
        end

        it 'gives all word forms for the third person' do
          feature_defs = { 'PERSON' => enumeration(:third),
            'PARADIGM' => [identifier, 'possdet_3rd_paradigm'] }
          test_all_inflections('its', feature_defs, %w[its her his their])
        end

        # it 'gives all word forms' do
          # test_all_inflections('this', ['this', 'that', 'these', 'those'])
        # end
      end # context
    end # describe
  end # module
end # module
