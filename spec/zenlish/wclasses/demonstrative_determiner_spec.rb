# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'
require_relative '../../../lib/zenlish/wclasses/demonstrative_determiner' # Load the class under test

module Zenlish
  module WClasses
    describe DemonstrativeDeterminer do
      subject(:determiner) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        def build_det(aBaseForm)
          entry = Zenlish::Lex::LexicalEntry.new(aBaseForm)
          Zenlish::Lex::Lexeme.new(determiner, entry)
        end

        def test_all_inflections(det_form, wforms)
          determiner = build_det(det_form)
          inflected = determiner.all_inflections
          expect(inflected.sort).to eq(wforms.sort)
        end

        it 'knows that it is inflectable' do
          expect(determiner).not_to be_invariable
        end

        it 'knows its feature definitions' do
          expect(determiner['NUMBER']).to be_a(Feature::FeatureDef)
          expect(determiner['DISTANCE']).to be_a(Feature::FeatureDef)
          expect(determiner['PARADIGM'].default.val).to eq('Demonstrative_det_paradigm')
        end

        it 'gives all word forms' do
          test_all_inflections('this', %w[this that these those])
        end
      end # context
    end # describe
  end # module
end # module
