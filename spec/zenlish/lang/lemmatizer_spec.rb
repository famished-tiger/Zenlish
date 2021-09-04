# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lang/dictionary'

# Load the class under test
require_relative '../../../lib/zenlish/lang/lemmatizer'

module Zenlish
  module Lang
    describe Lemmatizer do
      subject { Lemmatizer.new(Dictionary) }

      context 'Initialization:' do
        it 'should be initialized with a lexicon argument' do
          expect { Lemmatizer.new(Dictionary) }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'should retrieve an unambiguous word form' do
          # Coordinator
          found = subject.lemmatize('and')
          expect(found).to be_kind_of(Lex::Lexeme)
          expect(found.lemma).to eq('and')
          expect(found.wclass).to be_kind_of(WClasses::Coordinator)

          # Common noun
          found = subject.lemmatize('surfaces')
          expect(found).to be_kind_of(Lex::Lexeme)
          expect(found.lemma).to eq('surface')
          expect(found.wclass).to be_kind_of(WClasses::CommonNoun)

          # Verb
          found = subject.lemmatize('seeing')
          expect(found).to be_kind_of(Lex::Lexeme)
          expect(found.lemma).to eq('see')
          expect(found.wclass).to be_kind_of(WClasses::IrregularVerb)
        end
      end # context
    end # describe
  end # module
end # module
