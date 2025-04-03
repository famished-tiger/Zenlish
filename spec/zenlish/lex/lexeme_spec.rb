# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/wclasses/all_word_classes'
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/feature/feature_struct_def_bearer'
require_relative '../../../lib/zenlish/lex/lexeme' # Load the class under test

module Zenlish
  module Lex
    describe Lexeme do
      include Feature::FeatureStructDefBearer

      let(:a_wclass) { WClasses::CommonNoun.new }
      let(:a_lemma) { 'people' }
      let(:an_entry) { LexicalEntry.new(a_lemma) }
      let(:a_feat_struct_def) do
             { 'NUMBER' => enumeration(:plural),
               'PARADIGM' => [identifier, 'Plural_only'] }
      end

      subject(:a_lexeme) { described_class.new(a_wclass, an_entry) }

      context 'Initialization:' do
        it 'can be initialized with a word class and a lexical entry' do
          expect { described_class.new(a_wclass, an_entry) }.not_to raise_error
        end

        it 'can be initialized with a w. class, lexical ent., feature hash' do
          expect { described_class.new(a_wclass, an_entry, a_feat_struct_def) }.not_to raise_error
        end

        it 'knows its word class' do
          expect(a_lexeme.wclass).to eq(a_wclass)
        end

        it 'knows its lexical entry' do
          expect(a_lexeme.entry).to eq(an_entry)
        end
      end # context

      context 'Provided services:' do
        subject(:a_lexeme) { described_class.new(a_wclass, an_entry, a_feat_struct_def) }
        it 'knows its lemma' do
          expect(a_lexeme.lemma).to eq(a_lemma)
        end

        it 'knows its own feature defs' do
          instance = described_class.new(a_wclass, an_entry, a_feat_struct_def)
          expect(instance['NUMBER'].default.val).to eq(:plural)
        end

        it 'knows its inflection paradigm' do
          expect(a_lexeme.paradigm).to be_a(Inflect::InflectionTable)
        end

        it 'knows all its inflections' do
          expect(a_lexeme.all_inflections).to eq(['people'])
        end
      end # context
    end # describe
  end # module
end # module
