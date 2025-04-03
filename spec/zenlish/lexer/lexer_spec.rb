# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/wclasses/all_word_classes'
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'

# Load the class under test
require_relative '../../../lib/zenlish/lexer/lexer'

module Zenlish
  module Lexer
    describe Lexer do
      # let(:sample_wclass) { WClasses::CommonNoun.new }
      # let(:sample_lemma) { 'thing' }
      # let(:sample_entry) { LexicalEntry.new(sample_lemma) }
      # let(:sample_position) { double('position') }
      # let(:sample_lexeme) { Lexeme.new(sample_wclass, sample_entry)  }
      let(:sample_sentence) { 'Tony sees Lisa.' }

      subject(:lexer) { described_class.new(sample_sentence) }

      context 'Initialization:' do
        it 'is initialized with Zenlish text' do
          expect { described_class.new(sample_sentence) }.not_to raise_error
        end

        it 'knows its scanner object' do
          expect(lexer.scanner).not_to be_nil
        end

        it 'has an initial position' do
          expect(lexer.lineno).to eq(1)
          expect(lexer.line_start).to eq(0)
        end
      end # context

      context 'Provided services:' do
        it 'returns a sequence of literals' do
          tokens = lexer.tokens
          expect(tokens.size).to eq(4)
          expect(tokens[0].lexeme).to eq('Tony')
          expect(tokens[0].terminal).to eq('WORD')
          expect(tokens[1].lexeme).to eq('sees')
          expect(tokens[2].lexeme).to eq('Lisa')
          expect(tokens[3].lexeme).to eq('.')
          expect(tokens[3].terminal).to eq('Period')
        end
      end # context
    end # describe
  end # module
end # module
