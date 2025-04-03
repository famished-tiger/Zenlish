# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework'
require_relative '../../../lib/zenlish/lex/lexical_entry' # Load the class under test

module Zenlish
  module Lex
    describe LexicalEntry do
      let(:sample_lemma) { 'other' }
      let(:sample_lexeme1) { double('other-as-adjective') }
      let(:sample_lexeme2) { double('other-as-pronoun') }

      subject(:lex_entry) { described_class.new(sample_lemma) }

      context 'Initialization:' do
        it 'can be initialized with a lemma only' do
          expect { described_class.new(sample_lemma) }.not_to raise_error
        end

        it 'can be initialized with a lemma and a word class' do
          expect { described_class.new(sample_lemma, sample_lexeme1) }.not_to raise_error
        end

        it 'knows its lemma' do
          expect(lex_entry.lemma).to eq(sample_lemma)
        end

        it 'knows its lexeme (if any)' do
          expect(lex_entry.lexemes).to be_empty
          instance = described_class.new(sample_lemma, sample_lexeme1)
          expect(instance.lexemes).to eq([sample_lexeme1])
        end
      end # context

      context 'Provided services:' do
        it 'accepts links with lexeme(s)' do
          lex_entry.add_lexeme(sample_lexeme1)
          expect(lex_entry.lexemes).to eq([sample_lexeme1])

          lex_entry.add_lexeme(sample_lexeme2)
          expect(lex_entry.lexemes).to eq([sample_lexeme1, sample_lexeme2])
        end
      end # context
    end # describe
  end # module
end # module
