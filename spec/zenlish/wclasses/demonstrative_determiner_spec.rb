# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'
require_relative '../../../lib/zenlish/wclasses/demonstrative_determiner' # Load the class under test

module Zenlish
  module WClasses
    describe DemonstrativeDeterminer do
      subject { DemonstrativeDeterminer.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { DemonstrativeDeterminer.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        def build_det(aBaseForm)
          entry = Zenlish::Lex::LexicalEntry.new(aBaseForm)
          lexeme = Zenlish::Lex::Lexeme.new(subject, entry)
        end

        def test_all_inflections(det_form, wforms)
          determiner = build_det(det_form)
          inflected = determiner.all_inflections
          expect(inflected.sort).to eq(wforms.sort)
        end

        it 'should know that it is inflectable' do
          expect(subject).not_to be_invariable
        end

        it 'should know its feature definitions' do
          expect(subject['NUMBER']).to be_kind_of(Feature::FeatureDef)
          expect(subject['DISTANCE']).to be_kind_of(Feature::FeatureDef)
          expect(subject['PARADIGM'].default.val).to eq('Demonstrative_det_paradigm')
        end

        it 'should give all word forms' do
          test_all_inflections('this', ['this', 'that', 'these', 'those'])
        end
      end # context
    end # describe
  end # module
end # module
