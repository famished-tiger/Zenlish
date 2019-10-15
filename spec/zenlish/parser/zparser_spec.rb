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

      def get_lexeme(aLemma, aWordClass = nil)
        $ZenlishLexicon.get_lexeme(aLemma, aWordClass)
      end

      def self.literal2var(aLemma, aLiteral, aSuffix = '')
        mth_name = aLiteral.downcase + aSuffix
        define_method(mth_name.to_sym) do
          Lex::Literal.new(aLiteral, get_lexeme(aLemma), 0)
        end
      end

      # In absence of a POS tagger/lemmatizer, we map input words
      # to variables that themselves return Literal objects.
      # For instance, next line will create a variable called 'alive'
      literal2var('alive', 'alive')
      literal2var('all', 'all')
      literal2var('be', 'are')
      literal2var('big', 'big')
      literal2var('as', 'as')
      literal2var('of', 'of')
      literal2var('do', 'does')
      literal2var('inside', 'inside')
      def is ; Lex::Literal.new('is', get_lexeme('be', WClasses::IrregularVerbBe), 0) ; end
      literal2var('Lisa', 'Lisa')
      literal2var('living', 'living')
      literal2var('many', 'many')
      literal2var('more', 'more')
      literal2var('not', 'not', '_')
      literal2var('one', 'one')
      literal2var('two', 'two')
      literal2var('other', 'other')
      literal2var('people', 'people')
      literal2var('person', 'person')
      literal2var('same', 'same')
      literal2var('small', 'small')
      literal2var('some', 'some')
      literal2var('see', 'see')
      literal2var('see', 'sees')
      literal2var('something', 'something')
      literal2var('the', 'the')
      literal2var('than', 'than')
      literal2var('there', 'there')
      literal2var('thing', 'thing')
      literal2var('thing', 'things')
      literal2var('this', 'these')      
      literal2var('this', 'this')
      literal2var('this one', 'this_one')
      literal2var('Tony', 'Tony')
      literal2var('very', 'very')

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

          # Sentence 1-05b: "Tony sees the same person as Lisa sees."
          literals = [tony, sees, the, same, person, as, lisa, sees, dot]
          # same is an adjective of equality comparison
          # as is part of same ... as combination
          # it introduces a comparative clause
          expect { subject.parse(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 1-C' do
          # Sentence 1-09a: "Tony sees many things."
          literals = [tony, sees, many, things, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-09b: "Lisa sees many people."
          literals = [lisa, sees, many, people, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-10: "Tony is inside this thing."
          literals = [tony, is, inside, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-11: "Lisa is not inside this thing."
          literals = [lisa, is, not_, inside, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence: "Lisa does not see people inside the other thing."
          literals = [lisa, does, not_, see, people, inside, the, other, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 1-D' do
          # Sentence 1-12a: "Some of these people are inside this thing."
          literals = [some, of, these, people, are, inside, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-12b: "Some of these people are not inside this thing."
          literals = [some, of, these, people, are, not_, inside, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-13: "All of these people are inside this thing."
          literals = [all, of, these, people, are, not_, inside, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-14a: "There are two people inside one of these things."
          literals = [there, are, two, people, inside, one, of, these, things, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-14b: "There are not people inside the other thing."
          literals = [there, are, not_, people, inside, the, other, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-15a: "There are many people inside this thing."
          literals = [there, are, many, people, inside, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-15b: "There are more people inside this thing."
          literals = [there, are, more, people, inside, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-15c: "There are more people inside the other thing than there are inside this thing."
          literals = [there, are, more, people, inside, the, other, thing, than, there, are, inside, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 1-E' do
          # Sentence 1-16a: "Two of these things are alive."
          literals = [two, of, these, things, are, alive, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-16b: "One of these things is not alive."
          literals = [one, of, these, things, is, not_, alive, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-17a: "Tony sees some living things."
          literals = [tony, sees, some, living, things, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-17b: "Two of these things are big."
          literals = [two, of, these, things, are, big, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-17c: "One of these things is not big."
          literals = [one, of, these, things, is, not_, big, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-18a: "Tony sees some living things."
          literals = [tony, sees, some, living, things, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-18b: "One of these is big."
          literals = [one, of, these, is, big, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-18c: "Two of these are small."
          literals = [two, of, these, are, small, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-19a: "Tony sees one living thing."
          literals = [tony, sees, one, living, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-19b: "This one is very big."
          literals = [this_one, is, very, big, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # # Sentence: "This thing is bigger than the other thing."
          # literals = [this, thing, is, bigger very, big, dot]
          # expect { subject.parse(literals) }.not_to raise_error
        end
      end # context
    end # describe
  end # module
end # module
