# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework'
require_relative '../../../lib/zenlish/wclasses/all_word_classes'
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'
require_relative '../../../lib/zenlish/lex/lexicon' # Load the class under test

=begin

minimal_lexicon = Zenlish::Lex::Lexicon.new
ent = Zenlish::Lex::LexicalEntry.new('Lisa')
lexeme = Zenlish::Lex::Lexeme.new(o_proper_noun, ent)
minimal_lexicon.add_entry(ent)

ent = Zenlish::Lex::LexicalEntry.new('see')
lexeme = Zenlish::Lex::Lexeme.new(o_irregular_verb, ent)
minimal_lexicon.add_entry(ent)

ent = Zenlish::Lex::LexicalEntry.new('Tony')
lexeme = Zenlish::Lex::Lexeme.new(o_proper_noun, ent)
minimal_lexicon.add_entry(ent)
=end


module Zenlish
  module Lex
    describe Lexicon do
      def create_entry(aLemma, aWordClass)
        entry = Zenlish::Lex::LexicalEntry.new(aLemma)
        lexeme = Zenlish::Lex::Lexeme.new(aWordClass, entry)
        entry
      end

      let(:adjective) { Zenlish::WClasses::Adjective.new }
      let(:proper_noun) { Zenlish::WClasses::ProperNoun.new }
      let(:pronoun) { Zenlish::WClasses::Pronoun.new }
      let(:irregular_verb) { Zenlish::WClasses::IrregularVerb.new }

      let(:sample_lexeme) { double('other-as-adjective') }
      let(:sample_entry) { LexicalEntry.new('other', sample_lexeme) }
      let(:other_lexeme) { double('other-as-pronoun') }
      let(:similar_entry) { LexicalEntry.new('other', other_lexeme) }
      let(:verb_lexeme) { double('hope-as-verb') }
      let(:distinct_entry) {LexicalEntry.new('hope', verb_lexeme) }
      subject { Lexicon.new }

      context 'Initialization:' do
        it 'should be initialized without parameter' do
          expect { Lexicon.new }.not_to raise_error
        end

        it 'should have no registered terminals at initialization' do
          expect(subject.terminals).to be_empty
        end

        it 'should have no entry at initialization' do
          expect(subject.entries).to be_empty
          expect(subject.lemma2entry).to be_empty
        end
      end # context

      context 'Provided services:' do
        it 'should accept the addition of terminals' do
          terminal1 = proper_noun
          terminal2 = irregular_verb
          terminal3 = adjective

          subject.add_terminal(terminal1)
          expect(subject.terminals).to eq([terminal1])
          subject.add_terminal(terminal2)
          expect(subject.terminals).to eq([terminal1, terminal2])
          subject.add_terminal(terminal3)
          expect(subject.terminals).to eq([terminal1, terminal2, terminal3])
          expect(subject.name2terminal['ProperNoun']).to eq(terminal1)
          expect(subject.name2terminal['IrregularVerb']).to eq(terminal2)
          expect(subject.name2terminal['Adjective']).to eq(terminal3)
        end

        it 'should accept the addition of entries' do
          subject.add_entry(sample_entry)
          expect(subject.entries).to eq([sample_entry])
          expect(subject.lemma2entry['other']).to eq(sample_entry)

          # Add dissimilar entry
          subject.add_entry(distinct_entry)
          expect(subject.entries).to eq([sample_entry, distinct_entry])
          expect(subject.lemma2entry['hope']).to eq(distinct_entry)

          # Add "homonym" entry
          subject.add_entry(similar_entry)
          expect(subject.entries).to eq([sample_entry, distinct_entry, similar_entry])
          expect(subject.lemma2entry['other']).to eq([sample_entry, similar_entry])
        end

        it 'should complain when retrieving an non-existing entry' do
          subject.add_entry(sample_entry)
          err_msg = 'key not found: "hapax"'
          expect { subject.get_lexeme('hapax') }.to raise_error(KeyError, err_msg)
        end
      end # context
    end # describe
  end # module
end # module
