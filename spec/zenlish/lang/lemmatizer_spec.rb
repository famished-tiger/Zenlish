# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lang/dictionary'

# Load the class under test
require_relative '../../../lib/zenlish/lang/lemmatizer'

module Zenlish
  module Lang
    describe Lemmatizer do
      subject { described_class.new(Dictionary) }

      context 'Initialization:' do
        # it 'is initialized with a lexicon argument' do
        #   expect { described_class.new(Dictionary) }.not_to raise_error
        # end
      end # context

      context 'Provided services:' do
        # it 'retrieves an unambiguous word form' do
        #   # Coordinator
        #   found = described_class.lemmatize('and')
        #   expect(found).to be_a(Lex::Lexeme)
        #   expect(found.lemma).to eq('and')
        #   expect(found.wclass).to be_a(WClasses::Coordinator)
        #
        #   # Common noun
        #   found = described_class.lemmatize('surfaces')
        #   expect(found).to be_a(Lex::Lexeme)
        #   expect(found.lemma).to eq('surface')
        #   expect(found.wclass).to be_a(WClasses::CommonNoun)
        #
        #   # Verb
        #   found = described_class.lemmatize('seeing')
        #   expect(found).to be_a(Lex::Lexeme)
        #   expect(found.lemma).to eq('see')
        #   expect(found.wclass).to be_a(WClasses::IrregularVerb)
        # end
      end # context
    end # describe
  end # module
end # module
