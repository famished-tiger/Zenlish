# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/feature/feature_struct_def_bearer'

module Zenlish
  module Feature
    describe FeatureStructDefBearer do
      # @nodoc Class created just for testing purposes.
      # rubocop: disable Lint/ConstantDefinitionInBlock
      class Dummy
        include FeatureStructDefBearer

        def initialize(aParent)
          feature_hash = {
            'NUMBER' => enumeration(:singular, :plural),
            'COUNTABILITY' => boolean,
            'PARADIGM' => [identifier, 'CommonForm']
          }

          init_struct_def(aParent, feature_hash)
        end
      end # class
      # rubocop: enable Lint/ConstantDefinitionInBlock

      subject(:bearer) { Dummy.new(nil) }

      context 'Mix-in initialization' do
        it 'has initialized properly the injected data' do
          expect { Dummy.new(nil) }.not_to raise_error
          expect(bearer.struct).to be_a(FeatureStructDef)
        end

        it 'has the feature definitions created' do
          expect(bearer['NUMBER']).not_to be_nil
          expect(bearer['NUMBER']).to be_a(FeatureDef)
          ft = bearer['NUMBER']
          expect(ft.domain.enum).to eq(%i[singular plural])

          expect(bearer['COUNTABILITY']).to be_a(FeatureDef)
          expect(bearer['COUNTABILITY'].domain).to be_a(BooleanDomain)
          expect(bearer['PARADIGM']).to be_a(FeatureDef)
          expect(bearer['PARADIGM'].domain).to be_a(IdentifierDomain)
          expect(bearer['PARADIGM'].default).to be_a(IdentifierValue)
        end

        it 'supports the addition of feature def' do
          bearer.feature_def_dsl { feature_def 'CASE' => boolean }

          expect(bearer['CASE']).to be_a(FeatureDef)
          expect(bearer['CASE'].domain).to be_a(BooleanDomain)
        end
      end # context
    end # describe
  end # module
end # module
