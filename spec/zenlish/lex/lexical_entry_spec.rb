# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework'
require_relative '../../../lib/zenlish/lex/lexical_entry' # Load the class under test

module Zenlish
  module Lex
    describe LexicalEntry do
      let(:sample_lemma) { 'other' }
      let(:sample_lexeme1) { double('other-as-adjective') }
      let(:sample_lexeme2) { double('other-as-pronoun') }
      subject { LexicalEntry.new(sample_lemma) }

      context 'Initialization:' do
        it 'can be initialized with a lemma only' do
          expect { LexicalEntry.new(sample_lemma) }.not_to raise_error
        end

        it 'can be initialized with a lemma and a word class' do
          expect { LexicalEntry.new(sample_lemma, sample_lexeme1) }.not_to raise_error
        end

        it 'should know its lemma' do
          expect(subject.lemma).to eq(sample_lemma)
        end

        it 'should know its lexeme (if any)' do
          expect(subject.lexemes).to be_empty
          instance = LexicalEntry.new(sample_lemma, sample_lexeme1)
          expect(instance.lexemes).to eq([sample_lexeme1])
        end
      end # context

      context 'Provided services:' do
        it 'should accept links with lexeme(s)' do
          subject.add_lexeme(sample_lexeme1)
          expect(subject.lexemes).to eq([sample_lexeme1])

          subject.add_lexeme(sample_lexeme2)
          expect(subject.lexemes).to eq([sample_lexeme1, sample_lexeme2])
        end
      end # context
    end # describe
  end # module
end # module
