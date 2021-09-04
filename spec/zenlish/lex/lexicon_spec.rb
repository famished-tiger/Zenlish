# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework'
require_relative '../../../lib/zenlish/wclasses/all_word_classes'
require_relative '../../../lib/zenlish/lex/lexical_entry'
require_relative '../../../lib/zenlish/lex/lexeme'
require_relative '../../../lib/zenlish/lex/lexicon' # Load the class under test


module Zenlish
  module Lex
    describe Lexicon do
      def create_entry(aLemma, aWordClass)
        entry = Zenlish::Lex::LexicalEntry.new(aLemma)
        # lexeme =
        Zenlish::Lex::Lexeme.new(aWordClass, entry)
        entry
      end

      let(:adjective) { Zenlish::WClasses::Adjective.new }
      let(:pronoun) { Zenlish::WClasses::Pronoun.new }
      let(:irregular_verb) { Zenlish::WClasses::IrregularVerb.new }

      let(:sample_entry) { create_entry('other', adjective) }
      let(:similar_entry) { create_entry('other', pronoun) }
      let(:distinct_entry) { create_entry('hope', irregular_verb) }
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
          terminal1 = pronoun
          terminal2 = irregular_verb
          terminal3 = adjective

          subject.add_terminal(terminal1)
          expect(subject.terminals).to eq([terminal1])
          subject.add_terminal(terminal2)
          expect(subject.terminals).to eq([terminal1, terminal2])
          subject.add_terminal(terminal3)
          expect(subject.terminals).to eq([terminal1, terminal2, terminal3])
          expect(subject.name2terminal['Pronoun']).to eq(terminal1)
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

        it 'should retrieve the lexeme of an entry with unique lemma' do
          subject.add_entry(sample_entry)
          subject.add_entry(distinct_entry)
          subject.add_entry(similar_entry)

          lexeme = subject.get_lexeme('hope')
          expect(lexeme.wclass).to be_kind_of(Zenlish::WClasses::IrregularVerb)
        end

        it 'should retrieve the lexeme of an entry with duplicate lemma' do
          subject.add_entry(sample_entry)
          subject.add_entry(distinct_entry)
          subject.add_entry(similar_entry)

          lexeme = subject.get_lexeme('other', Zenlish::WClasses::Pronoun)
          expect(lexeme).to be_kind_of(Zenlish::Lex::Lexeme)
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
