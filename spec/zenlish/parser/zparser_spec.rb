# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../support/minimal_lexicon'
require_relative '../../../lib/zenlish/lex/literal'
require_relative '../../../lib/zenlish/parser/zparser' # Load the class under test

module Zenlish
  module Parser
    describe ZParser do
      subject { ZParser.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { ZParser.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        def get_lexeme(aLemma)
          $ZenlishLexicon.get_lexeme(aLemma)
        end

        let(:tony) do
          Lex::Literal.new('Tony', $ZenlishLexicon.get_lexeme('Tony'), 0)
        end
        let(:lisa) do
          Lex::Literal.new('Lisa', $ZenlishLexicon.get_lexeme('Lisa'), 0)
        end
        let(:the) do
          Lex::Literal.new('the', $ZenlishLexicon.get_lexeme('the'), 0)
        end
        let(:other) do
          Lex::Literal.new('other', $ZenlishLexicon.get_lexeme('other'), 0)
        end
        let(:sees) do
          Lex::Literal.new('sees', $ZenlishLexicon.get_lexeme('see'), 0)
        end
        let(:dot) do
          Lex::Literal.new('.', $ZenlishLexicon.get_lexeme('.'), 0)
        end
        let(:something) do
          Lex::Literal.new('something', $ZenlishLexicon.get_lexeme('something'), 0)
        end
        let(:thing) do
          Lex::Literal.new('thing', $ZenlishLexicon.get_lexeme('thing'), 0)
        end
        let(:this) do
          Lex::Literal.new('this', $ZenlishLexicon.get_lexeme('this'), 0)
        end

        it 'should parse sample sentence 1-01' do
          # Sentence is: "Tony sees Lisa."
          # in absence of a tokenizer, we create a sequence of literals by hand...
          literals = [tony, sees, lisa, dot]
          expect { subject.parse(literals) }.not_to raise_error
        end

        it 'should parse sample sentence 1-02a' do
          # Sentence is: "Tony sees something."
          sentence_literals = [tony, sees, something, dot]
          expect { subject.parse(sentence_literals) }.not_to raise_error
        end

        it 'should parse sample sentence 1-02b' do
          # Sentence is: "Lisa sees something"
          sentence_literals = [lisa, sees, something, dot]
          expect { subject.parse(sentence_literals) }.not_to raise_error
        end

        it 'should parse sample sentence 1-03' do
          # Sentence is: "Tony sees this thing."
          sentence_literals = [tony, sees, this, thing, dot]
          expect { subject.parse(sentence_literals) }.not_to raise_error
        end

        it 'should parse sample sentence 1-04' do
          # Sentence is: "Lisa sees the other thing."
          sentence_literals = [lisa, sees, the, other, thing, dot]
          expect { subject.parse(sentence_literals) }.not_to raise_error
        end
      end # context
    end # describe
  end # module
end # module

