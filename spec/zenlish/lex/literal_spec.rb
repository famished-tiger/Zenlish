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
      let(:sample_position) { double('position') }
      let(:sample_lexeme) { Lexeme.new(sample_wclass, sample_entry) }

      subject { Literal.new('things', sample_lexeme, sample_position) }

      context 'Initialization:' do
        it 'should be initialized with a string, a lexeme and a position' do
          expect { Literal.new('things', sample_lexeme, sample_position) }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'should know its lexeme' do
          expect(subject.zlexeme).to eq(sample_lexeme)
        end
      end # context
    end # describe
  end # module
end # module
