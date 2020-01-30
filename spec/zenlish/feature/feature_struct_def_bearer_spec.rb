# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/feature/feature_struct_def_bearer'

module Zenlish
  module Feature
    describe FeatureStructDefBearer do
      # @nodoc Class created just for testing purposes.
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

      subject { Dummy.new (nil) }

      context 'Mix-in initialization' do
        it 'should have initialized properly the injected data' do
          expect { Dummy.new(nil) }.not_to raise_error
          expect(subject.struct).to be_kind_of(FeatureStructDef)
        end

        it 'should have the feature definitions created' do
          expect(subject['NUMBER']).not_to be_nil
          expect(subject['NUMBER']).to be_kind_of(FeatureDef)
          ft = subject['NUMBER']
          expect(ft.domain.enum).to eq([:singular, :plural])
          
          expect(subject['COUNTABILITY']).to be_kind_of(FeatureDef)
          expect(subject['COUNTABILITY'].domain).to be_kind_of(BooleanDomain)
          expect(subject['PARADIGM']).to be_kind_of(FeatureDef)
          expect(subject['PARADIGM'].domain).to be_kind_of(IdentifierDomain)
          expect(subject['PARADIGM'].default).to be_kind_of(IdentifierValue)          
        end
        
        it 'should support the addition of feature def' do
          subject.feature_def_dsl { feature_def 'CASE' => boolean }
          
          expect(subject['CASE']).to be_kind_of(FeatureDef)
          expect(subject['CASE'].domain).to be_kind_of(BooleanDomain)          
        end
      end # context
    end # describe
  end # module
end # module