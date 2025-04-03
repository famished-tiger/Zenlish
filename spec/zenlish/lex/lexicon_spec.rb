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

      subject(:lexicon) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without parameter' do
          expect { described_class.new }.not_to raise_error
        end

        it 'has no registered terminals at initialization' do
          expect(lexicon.terminals).to be_empty
        end

        it 'has no entry at initialization' do
          expect(lexicon.entries).to be_empty
          expect(lexicon.lemma2entry).to be_empty
        end
      end # context

      context 'Provided services:' do
        it 'accepts the addition of terminals' do
          terminal1 = pronoun
          terminal2 = irregular_verb
          terminal3 = adjective

          lexicon.add_terminal(terminal1)
          expect(lexicon.terminals).to eq([terminal1])
          lexicon.add_terminal(terminal2)
          expect(lexicon.terminals).to eq([terminal1, terminal2])
          lexicon.add_terminal(terminal3)
          expect(lexicon.terminals).to eq([terminal1, terminal2, terminal3])
          expect(lexicon.name2terminal['Pronoun']).to eq(terminal1)
          expect(lexicon.name2terminal['IrregularVerb']).to eq(terminal2)
          expect(lexicon.name2terminal['Adjective']).to eq(terminal3)
        end

        it 'accepts the addition of entries' do
          lexicon.add_entry(sample_entry)
          expect(lexicon.entries).to eq([sample_entry])
          expect(lexicon.lemma2entry['other']).to eq(sample_entry)

          # Add dissimilar entry
          lexicon.add_entry(distinct_entry)
          expect(lexicon.entries).to eq([sample_entry, distinct_entry])
          expect(lexicon.lemma2entry['hope']).to eq(distinct_entry)

          # Add "homonym" entry
          lexicon.add_entry(similar_entry)
          expect(lexicon.entries).to eq([sample_entry, distinct_entry, similar_entry])
          expect(lexicon.lemma2entry['other']).to eq([sample_entry, similar_entry])
        end

        it 'retrieves the lexeme of an entry with unique lemma' do
          lexicon.add_entry(sample_entry)
          lexicon.add_entry(distinct_entry)
          lexicon.add_entry(similar_entry)

          lexeme = lexicon.get_lexeme('hope')
          expect(lexeme.wclass).to be_a(Zenlish::WClasses::IrregularVerb)
        end

        it 'retrieves the lexeme of an entry with duplicate lemma' do
          lexicon.add_entry(sample_entry)
          lexicon.add_entry(distinct_entry)
          lexicon.add_entry(similar_entry)

          lexeme = lexicon.get_lexeme('other', Zenlish::WClasses::Pronoun)
          expect(lexeme).to be_a(Zenlish::Lex::Lexeme)
        end

        it 'complains when retrieving an non-existing entry' do
          lexicon.add_entry(sample_entry)
          err_msg = 'key not found: "hapax"'
          expect { lexicon.get_lexeme('hapax') }.to raise_error(KeyError, err_msg)
        end
      end # context
    end # describe
  end # module
end # module
