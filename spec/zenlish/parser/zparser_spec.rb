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
      literal2var('about', 'about')
      literal2var('above', 'above')
      literal2var('alive', 'alive')
      literal2var('all', 'all')
      literal2var('another', 'another')
      def are ;     Lex::Literal.new('are', get_lexeme('be', WClasses::IrregularVerbBe), 0) ; end
      literal2var('because', 'because')
      literal2var('big', 'big')
      literal2var('big', 'bigger')
      literal2var('as', 'as')
      literal2var('of', 'of')
      def does ; Lex::Literal.new('does', get_lexeme('do', WClasses::IrregularVerbDo), 0) ; end
      def does_aux ; Lex::Literal.new('does', get_lexeme('do', WClasses::AuxiliaryDo), 0) ; end
      literal2var('false', 'false', '_')
      literal2var('far', 'far')
      literal2var('from', 'from')
      literal2var('happen', 'happens')
      literal2var('have', 'has')
      literal2var('have', 'have')
      literal2var('hear', 'hears')
      literal2var('if', 'if', '_')
      literal2var('in', 'in', '_')
      literal2var('inside', 'inside')
      def is ;     Lex::Literal.new('is', get_lexeme('be', WClasses::IrregularVerbBe), 0) ; end
      def is_aux ; Lex::Literal.new('is', get_lexeme('be', WClasses::AuxiliaryBe), 0) ; end
      literal2var('kind', 'kind')
      literal2var('like', 'like')
      literal2var('Lisa', 'Lisa')
      literal2var('living', 'living')
      literal2var('many', 'many')
      literal2var('more', 'more')
      literal2var('near to', 'near_to')
      literal2var('not', 'not', '_')
      literal2var('on', 'on')
      literal2var('one', 'one')
      literal2var('other', 'other')
      literal2var('part', 'part')
      literal2var('people', 'people')
      literal2var('person', 'person')
      literal2var('place', 'place')
      literal2var('same', 'same')
      literal2var('side', 'side')
      literal2var('small', 'small')
      literal2var('small', 'smaller')
      literal2var('some', 'some')
      literal2var('say', 'says')
      literal2var('see', 'see')
      literal2var('see', 'sees')
      literal2var('something', 'something')
      literal2var('the', 'the')
      literal2var('then', 'then', '_')
      literal2var('than', 'than')
      literal2var('there', 'there')
      literal2var('thing', 'thing')
      literal2var('thing', 'things')
      def these ; Lex::Literal.new('these', get_lexeme('this', WClasses::DemonstrativeDeterminer), 0) ; end
      def these_as_pronoun ; Lex::Literal.new('these', get_lexeme('this', WClasses::DemonstrativePronoun), 0) ; end
      def this ; Lex::Literal.new('this', get_lexeme('this', WClasses::DemonstrativeDeterminer), 0) ; end
      def this_as_pronoun ; Lex::Literal.new('this', get_lexeme('this', WClasses::DemonstrativePronoun), 0) ; end
      literal2var('this one', 'this_one')
      literal2var('to', 'to')
      literal2var('Tony', 'Tony')
      literal2var('touch', 'touching')
      literal2var('true', 'true', '_')
      literal2var('two', 'two')
      literal2var('very', 'very')
      literal2var('what', 'what')
      literal2var('with', 'with')
      literal2var('word', 'words')

      def colon ;  Lex::Literal.new(':', get_lexeme(':'), 0) ; end
      def comma ;  Lex::Literal.new(',', get_lexeme(','), 0) ; end
      def dot ;  Lex::Literal.new('.', get_lexeme('.'), 0) ; end
      def quote ;  Lex::Literal.new('"', get_lexeme('"'), 0) ; end

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
          literals = [lisa, does_aux, not_, see, people, inside, the, other, thing, dot]
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

          # Sentence: "This thing is bigger than the other thing."
          literals = [this, thing, is, bigger, than, the, other, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence: "This thing is smaller than the other thing."
          literals = [this, thing, is, smaller, than, the, other, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 1-F' do
          # Sentence 1-20a: "Tony sees some living things."
          literals = [tony, sees, some, living, things, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-20b: "Two of these are the same kind of living thing."
          literals = [these_as_pronoun, are, the, same, kind, of, living, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-20c: "One of these is not the same kind as the other two."
          literals = [one, of, these, is, not_, the, same, kind, as, the, other, two, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-21a: "There is one person inside this thing."
          literals = [there, is, one, person, inside, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-21b: "If Tony is not inside this thing, then another person is inside."
          literals = [if_, tony, is, not_, inside, this, thing, comma, then_,
            another, person, is, inside, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-22a: "Tony is touching something."
          literals = [tony, is_aux, touching, something, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-22b: "Lisa is touching Tony."
          literals = [lisa, is_aux, touching, tony, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-23a: "Tony is far from Lisa."
          literals = [tony, is, far, from, lisa, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-23b: "Lisa is far from Tony."
          literals = [lisa, is, far, from, tony, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-23c: "Tony is not far from Lisa."
          literals = [tony, is, far, from, lisa, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-24: "Tony is near to Lisa."
          literals = [tony, is, near_to, lisa, dot]
          expect { subject.parse(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 1-G' do
          # Sentence 1-25a: "Lisa is in this place."
          literals = [lisa, is, in_, this, place, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-25b: "There are two other things in this place."
          literals = [there, are, two, other, things, in_, this, place, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-25c: "Lisa is in the same place as these two other things."
          literals = [lisa, is, in_, the, same, place, as, these, two, other, things, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-25d: "Tony is not in this place."
          literals = [tony, is, not_, in_, this, place, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-25e: "Tony is in another place."
          literals = [tony, is, in_, another, place, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-26a: "Lisa is inside this thing."
          literals = [lisa, is, inside, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-26b: "Tony is above this thing."
          literals = [tony, is, above, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-26c: "Tony is above lisa."
          literals = [tony, is, above, lisa, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-27a: "Tony is on one side of this thing."
          literals = [tony, is, on, one, side, of, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-27b: "Lisa is on the other side."
          literals = [lisa, is, on, the, other, side, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-27c: "Tony is touching one side of this thing."
          literals = [tony, is_aux, touching, one, side, of, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 1-H' do
          # Sentence 1-28: "Tony hears something."
          literals = [tony, hears, something, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-29a: "Tony says something."
          literals = [tony, says, something, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-29b: "Tony says something to Lisa."
          literals = [tony, says, something, to, lisa, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-29c: "Tony says something about this living thing."
          literals = [tony, says, something, about, this, living, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-29d: 'Tony says: "This living thing is small."'
          literals = [tony, says, colon, quote, this, living, thing, is, small, dot, quote, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-30a: "Tony says some words."
          literals = [tony, says, some, words, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-30b: "Lisa says more words."
          literals = [lisa, says, more, words, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-31a: 'Tony says: "There are two people inside this thing."'
          literals = [tony, says, colon, quote, there, are, two, people, inside,
            this, thing, dot, quote, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-31b: 'Lisa says: "There is one person inside this thing."'
          literals = [lisa, says, colon, quote, there, is, one, person, inside,
            this, thing, dot, quote, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-31c: "What Tony says is not true."
          literals = [what, tony, says, is, not_, true_, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 1-31d: "What Lisa says is true."
          literals = [what, lisa, says, is, true_, dot]
          expect { subject.parse(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 2-A' do
          # Sentence 2-01a: "This thing is like two of the other things."
          literals = [this, thing, is, like, two, of, the, other, things, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 2-01b: "One of these things is not like the other things."
          literals = [one, of, these, things, is, not_, like, the, other, things, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 2-02a: "Lisa has something."
          literals = [lisa, has, something, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 2-02b: "Tony has another thing."
          literals = [tony, has, another, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 2-02c: "Lisa does not have the same kind of thing as Tony has."
          literals = [lisa, does_aux, not_, have, the, same, kind, of, thing, as, tony, has, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 2-03a: "Lisa is touching part of this thing."
          literals = [lisa, is_aux, touching, part, of, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 2-03b: "Tony is touching the other part."
          literals = [tony, is_aux, touching, the, other, part, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 2-04a: "Lisa does something."
          literals = [lisa, does, something, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 2-04b: "Lisa does something with this thing."
          literals = [lisa, does, something, with, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 2-04c: "Lisa does something to Tony."
          literals = [lisa, does, something, to, tony, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 2-04d: "Lisa does something to Tony with this thing."
          literals = [lisa, does, something, to, tony, with, this, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 2-05a: "Something happens."
          literals = [something, happens, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 2-05b: "Something happens to Lisa."
          literals = [something, happens, to, lisa, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 2-06a: "Tony does something."
          literals = [tony, does, something, dot]
          expect { subject.parse(literals) }.not_to raise_error

          # Sentence 2-06b: "Something happens to Lisa because of this."
          literals = [something, happens, to, lisa, because, of, this_as_pronoun, dot]
          expect { subject.parse(literals) }.not_to raise_error
          
          # Sentence 2-06c: "Something happens to Lisa because Tony does this."
          literals = [something, happens, to, lisa, because, tony, does, this_as_pronoun, dot]
          expect { subject.parse(literals) }.not_to raise_error          
          
          # Sentence 2-06: "Something happens to this living thing."
          literals = [something, happens, to, this, living, thing, dot]
          expect { subject.parse(literals) }.not_to raise_error
        end
=begin
TODO
Lesson 2.A
	Xtra:
		What Tony has is like what Lisa has.
=end
      end # context
    end # describe
  end # module
end # module
