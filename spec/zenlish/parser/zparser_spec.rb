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

      def get_lexeme(aLemma)
        $ZenlishLexicon.get_lexeme(aLemma)
      end

      def as ; Lex::Literal.new('as', get_lexeme('as'), 0) ; end
      def lisa ; Lex::Literal.new('Lisa', get_lexeme('Lisa'), 0) ; end
      def one ;  Lex::Literal.new('one', get_lexeme('one'), 0) ; end
      def two ;  Lex::Literal.new('two', get_lexeme('two'), 0) ; end
      def other ;  Lex::Literal.new('other', get_lexeme('other'), 0) ; end
      def people ;  Lex::Literal.new('people', get_lexeme('people'), 0) ; end
      def person ;  Lex::Literal.new('person', get_lexeme('person'), 0) ; end
      def same ;  Lex::Literal.new('same', get_lexeme('same'), 0) ; end
      def sees ; Lex::Literal.new('sees', get_lexeme('see'), 0) ; end
      def something ;  Lex::Literal.new('something', get_lexeme('something'), 0) ; end
      def the ;  Lex::Literal.new('the', get_lexeme('the'), 0) ; end
      def thing ;  Lex::Literal.new('thing', get_lexeme('thing'), 0) ; end
      def things ;  Lex::Literal.new('things', get_lexeme('thing'), 0) ; end
      def this ;  Lex::Literal.new('this', get_lexeme('this'), 0) ; end
      def tony ;  Lex::Literal.new('Tony', get_lexeme('Tony'), 0) ; end
      def dot ;  Lex::Literal.new('.', get_lexeme('.'), 0) ; end

      class ZProxy
        attr_reader :literal

        def initialize(aTarget)
          @literal = aTarget
        end

        def method_missing(name, *args, &aBlock)
          puts "#{literal.lexeme} about to receive #{name}"
          $stdout.flush
          literal.send(name, *args, &aBlock)
        end
      end

      context 'Parsing lessons:' do
        it 'should parse sample sentences from lesson 1-A' do
          # Sentence 1-01: "Tony sees Lisa."
          # in absence of a tokenizer, we create a sequence of literals by hand...
          # prox_tony = ZProxy.new(tony)
          literals = [tony, sees, lisa, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-02a: "Tony sees something."
          sentence_literals = [tony, sees, something, dot]
          expect { subject.parse(sentence_literals) }.not_to raise_error

          # Sentence 1-02b: "Lisa sees something."
          sentence_literals = [lisa, sees, something, dot]
          expect { subject.parse(sentence_literals) }.not_to raise_error

          # Sentence 1-03: "Tony sees this thing."
          sentence_literals = [tony, sees, this, thing, dot]
          expect { subject.parse(sentence_literals) }.not_to raise_error

          # Sentence 1-04: "Lisa sees the other thing."
          sentence_literals = [lisa, sees, the, other, thing, dot]
          expect { subject.parse(sentence_literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 1-B' do
          # Sentence 1-05a: "Lisa sees the same thing."
          literals = [lisa, sees, the, same, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-05b: "Lisa sees the same thing as Tony sees."
          literals = [lisa, sees, the, same, thing, as, tony, sees, dot]
          # same is an adjective of equality comparison
          # as is part of same ... as combination
          # it introduces a comparative clause
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-06: "Tony sees one thing."
          literals = [tony, sees, one, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-07: "Lisa sees two things."
          literals = [lisa, sees, two, things, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-08a: "Tony sees one person."
          literals = [tony, sees, one, person, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-08b: "Lisa sees two people."
          literals = [lisa, sees, two, people, dot]
          expect { subject.parse(literals) }.not_to raise_error
        end
      end # context
    end # describe
  end # module
end # module

