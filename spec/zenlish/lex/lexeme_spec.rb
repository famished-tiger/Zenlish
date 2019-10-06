# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/wclasses/all_word_classes'
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme' # Load the class under test

module Zenlish
  module Lex
    describe Lexeme do
      let(:sample_wclass) { WClasses::CommonNoun.new }
      let(:sample_lemma) { 'thing' }
      let(:sample_entry) { LexicalEntry.new(sample_lemma) }

      subject { Lexeme.new(sample_wclass, sample_entry)  }

      context 'Initialization:' do
        it 'should be initialized with a word class and a lexical entry' do
          expect { Lexeme.new(sample_wclass, sample_entry) }.not_to raise_error
        end

        it 'should know its word class' do
          expect(subject.wclass).to eq(sample_wclass)
        end

        it 'should know its lexical entry' do
          expect(subject.entry).to eq(sample_entry)
        end
      end # context

      context 'Provided services:' do
        it 'should know its lemma' do
          expect(subject.lemma).to eq(sample_lemma)
        end
      end # context
    end # describe
  end # module
end # module

