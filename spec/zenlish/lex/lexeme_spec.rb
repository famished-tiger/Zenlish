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
      let(:a_feat_struct_def) {
             { 'NUMBER' => enumeration(:plural) }
      }

      subject { Lexeme.new(a_wclass, an_entry)  }

      context 'Initialization:' do
        it 'could be initialized with a word class and a lexical entry' do
          expect { Lexeme.new(a_wclass, an_entry) }.not_to raise_error
        end
        
        it 'could be initialized with a w. class, lexical ent., feature hash' do
          expect { Lexeme.new(a_wclass, an_entry, a_feat_struct_def) }.not_to raise_error
        end        

        it 'should know its word class' do
          expect(subject.wclass).to eq(a_wclass)
        end

        it 'should know its lexical entry' do
          expect(subject.entry).to eq(an_entry)
        end
      end # context

      context 'Provided services:' do
        it 'should know its lemma' do
          expect(subject.lemma).to eq(a_lemma)
        end
        
        it 'should know its own feature defs' do
          instance =  Lexeme.new(a_wclass, an_entry, a_feat_struct_def)
          expect(instance['NUMBER'].default.val).to eq(:plural)
        end
        
        it 'should know its inflection paradigm' do
          expect(subject.paradigm).to be_kind_of(Inflect::InflectionTable)
        end
      end # context
    end # describe
  end # module
end # module

