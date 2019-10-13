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

      def all ; Lex::Literal.new('all', get_lexeme('all'), 0) ; end      
      def are ; Lex::Literal.new('are', get_lexeme('be'), 0) ; end
      def as ; Lex::Literal.new('as', get_lexeme('as'), 0) ; end
      def of ; Lex::Literal.new('of', get_lexeme('of'), 0) ; end
      def does ; Lex::Literal.new('does', get_lexeme('do'), 0) ; end
      def inside ; Lex::Literal.new('inside', get_lexeme('inside'), 0) ; end
      def is ; Lex::Literal.new('is', get_lexeme('be', WClasses::IrregularVerbBe), 0) ; end
      def lisa ; Lex::Literal.new('Lisa', get_lexeme('Lisa'), 0) ; end
      def many ; Lex::Literal.new('many', get_lexeme('many'), 0) ; end
      def more ; Lex::Literal.new('more', get_lexeme('more'), 0) ; end      
      def not_ ; Lex::Literal.new('not', get_lexeme('not'), 0) ; end
      def one ;  Lex::Literal.new('one', get_lexeme('one'), 0) ; end
      def two ;  Lex::Literal.new('two', get_lexeme('two'), 0) ; end
      def other ;  Lex::Literal.new('other', get_lexeme('other'), 0) ; end
      def people ;  Lex::Literal.new('people', get_lexeme('people'), 0) ; end
      def person ;  Lex::Literal.new('person', get_lexeme('person'), 0) ; end
      def same ;  Lex::Literal.new('same', get_lexeme('same'), 0) ; end
      def some_ ;  Lex::Literal.new('some', get_lexeme('some'), 0) ; end
      def see ; Lex::Literal.new('see', get_lexeme('see'), 0) ; end
      def sees ; Lex::Literal.new('sees', get_lexeme('see'), 0) ; end
      def something ;  Lex::Literal.new('something', get_lexeme('something'), 0) ; end
      def the ;  Lex::Literal.new('the', get_lexeme('the'), 0) ; end
      def than ;  Lex::Literal.new('than', get_lexeme('than'), 0) ; end      
      def there ;  Lex::Literal.new('there', get_lexeme('there'), 0) ; end      
      def these ;  Lex::Literal.new('these', get_lexeme('this'), 0) ; end
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
          literals = [some_, of, these, people, are, inside, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error
          
          # Sentence 1-12b: "Some of these people are not inside this thing."
          literals = [some_, of, these, people, are, not_, inside, this, thing, dot]
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
      end # context
    end # describe
  end # module
end # module
