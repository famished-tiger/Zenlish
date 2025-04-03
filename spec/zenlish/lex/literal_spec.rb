# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/wclasses/all_word_classes'
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'
require_relative '../../../lib/zenlish/lex/literal' # Load the class under test

module Zenlish
  module Lex
    describe Literal do
      let(:sample_wclass) { WClasses::CommonNoun.new }
      let(:sample_lemma) { 'thing' }
      let(:sample_entry) { LexicalEntry.new(sample_lemma) }
      let(:sample_position) { instance_double(Rley::Lexical::Position) }
      let(:sample_lexeme) { Lexeme.new(sample_wclass, sample_entry) }

      subject(:literal) { described_class.new('things', sample_lexeme, sample_position) }

      context 'Initialization:' do
        it 'is initialized with a string, a lexeme and a position' do
          expect { described_class.new('things', sample_lexeme, sample_position) }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'knows its lexeme' do
          expect(literal.zlexeme).to eq(sample_lexeme)
        end
      end # context
    end # describe
  end # module
end # module
