# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lex/literal'
require_relative '../support/minimal_lexicon'
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
        Zenlish::Lang::Dictionary.get_lexeme(aLemma, aWordClass)
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
      literal2var('a', 'a', '_as_art')
      literal2var('about', 'about')
      literal2var('above', 'above')
      def after_adverb ; Lex::Literal.new('after', get_lexeme('after', WClasses::Adverb), 0) ; end
      def after_ ; Lex::Literal.new('after', get_lexeme('after', WClasses::SubordinatingConjunction), 0) ; end
      literal2var('alive', 'alive')
      literal2var('all', 'all')
      def am ; Lex::Literal.new('am', get_lexeme('be', WClasses::IrregularVerbBe), 0) ; end
      literal2var('another', 'another')
      def are ;     Lex::Literal.new('are', get_lexeme('be', WClasses::IrregularVerbBe), 0) ; end
      literal2var('as', 'as')
      literal2var('at', 'at')
      literal2var('bad', 'bad')
      def be_ ; Lex::Literal.new('be', get_lexeme('be', WClasses::IrregularVerbBe), 0) ; end
      literal2var('because', 'because')
      def before_adverb ; Lex::Literal.new('before', get_lexeme('before', WClasses::Adverb), 0) ; end
      def before ; Lex::Literal.new('before', get_lexeme('before', WClasses::SubordinatingConjunction), 0) ; end
      literal2var('below', 'below')
      literal2var('big', 'big')
      literal2var('big', 'bigger')
      literal2var('body', 'body')
      literal2var('can', 'can')
      def did ; Lex::Literal.new('did', get_lexeme('do', WClasses::IrregularVerbDo), 0) ; end
      literal2var('die', 'died')
      literal2var('die', 'dies')
      def do_ ; Lex::Literal.new('do', get_lexeme('do', WClasses::IrregularVerbDo), 0) ; end
      def do_aux ; Lex::Literal.new('do', get_lexeme('do', WClasses::AuxiliaryDo), 0) ; end
      def does ; Lex::Literal.new('does', get_lexeme('do', WClasses::IrregularVerbDo), 0) ; end
      def does_aux ; Lex::Literal.new('does', get_lexeme('do', WClasses::AuxiliaryDo), 0) ; end
      literal2var('false', 'false', '_')
      literal2var('far', 'far')
      literal2var('far from', 'far_from')
      literal2var('feel', 'feel')
      literal2var('feel', 'feels')
      literal2var('feel', 'felt')
      literal2var('for', 'for', '_')
      literal2var('from', 'from')
      literal2var('good', 'good')
      literal2var('happen', 'happen')
      literal2var('happen', 'happened')
      literal2var('happen', 'happening')
      literal2var('happen', 'happens')
      literal2var('have', 'has')
      literal2var('have', 'have')
      literal2var('hear', 'hears')
      def here ;     Lex::Literal.new('here', get_lexeme('here', WClasses::Adverb), 0) ; end
      def here_as_noun ;  Lex::Literal.new('here', get_lexeme('here', WClasses::CommonNoun), 0) ; end
      def i_pronoun ; Lex::Literal.new('I', get_lexeme('I'), 0) ; end
      literal2var('if', 'if', '_')
      literal2var('in', 'in', '_')
      literal2var('inside', 'inside')
      literal2var('J', 'j', '_')
      def is ;     Lex::Literal.new('is', get_lexeme('be', WClasses::IrregularVerbBe), 0) ; end
      def is_aux ; Lex::Literal.new('is', get_lexeme('be', WClasses::AuxiliaryBe), 0) ; end
      literal2var('K', 'k', '_')
      literal2var('kind', 'kind')
      literal2var('know', 'knew')
      literal2var('know', 'know')
      literal2var('know', 'knows')
      literal2var('like', 'like')
      literal2var('Lisa', 'Lisa')
      literal2var('live', 'lived')
      literal2var('living', 'living')
      literal2var('long', 'long')
      literal2var('many', 'many')
      literal2var('maybe', 'maybe')
      literal2var('me', 'me')
      literal2var('moment', 'moment')
      def more ; Lex::Literal.new('more', get_lexeme('more', WClasses::Adjective), 0) ; end
      def more_as_adverb ; Lex::Literal.new('more', get_lexeme('more', WClasses::Adverb), 0) ; end
      literal2var('move', 'move')
      literal2var('move', 'moved')
      literal2var('move', 'moving')      
      literal2var('move', 'moves')
      literal2var('much', 'much')
      literal2var('near', 'near')
      literal2var('near to', 'near_to')
      literal2var('not', 'not', '_')
      literal2var('now', 'now')
      literal2var('of', 'of')
      literal2var('on', 'on')
      def one ; Lex::Literal.new('one', get_lexeme('one', WClasses::Cardinal), 0) ; end
      def one_as_pronoun ; Lex::Literal.new('one', get_lexeme('one', WClasses::IndefinitePronoun), 0) ; end
      literal2var('other', 'other')
      literal2var('part', 'part')
      literal2var('part', 'parts')
      literal2var('people', 'people')
      literal2var('person', 'person')
      literal2var('place', 'place')
      literal2var('same', 'same')
      literal2var('short', 'short')
      literal2var('side', 'side')
      literal2var('small', 'small')
      literal2var('small', 'smaller')
      literal2var('some', 'some')
      literal2var('say', 'said')
      literal2var('say', 'says')
      literal2var('see', 'see')
      literal2var('see', 'sees')
      literal2var('someone', 'someone')
      literal2var('something', 'something')
      literal2var('the', 'the')
      literal2var('then', 'then', '_')
      literal2var('than', 'than')
      literal2var('there', 'there')
      literal2var('thing', 'thing')
      literal2var('thing', 'things')
      literal2var('think', 'think')
      literal2var('think', 'thinking')
      literal2var('think', 'thinks')
      def these ; Lex::Literal.new('these', get_lexeme('this', WClasses::DemonstrativeDeterminer), 0) ; end
      def these_as_pronoun ; Lex::Literal.new('these', get_lexeme('this', WClasses::DemonstrativePronoun), 0) ; end
      def this ; Lex::Literal.new('this', get_lexeme('this', WClasses::DemonstrativeDeterminer), 0) ; end
      def this_as_pronoun ; Lex::Literal.new('this', get_lexeme('this', WClasses::DemonstrativePronoun), 0) ; end
      literal2var('this one', 'this_one')
      literal2var('time', 'time')
      literal2var('to', 'to')
      literal2var('Tony', 'Tony')
      literal2var('touch', 'touch')
      literal2var('touch', 'touching')
      literal2var('true', 'true', '_')
      def two ; Lex::Literal.new('two', get_lexeme('two', WClasses::Cardinal), 0) ; end
      def two_as_pronoun ; Lex::Literal.new('two', get_lexeme('two', WClasses::IndefinitePronoun), 0) ; end
      literal2var('very', 'very')
      literal2var('want', 'want')
      literal2var('want', 'wants')
      def was ; Lex::Literal.new('was', get_lexeme('be', WClasses::IrregularVerbBe), 0) ; end
      def were ;     Lex::Literal.new('were', get_lexeme('be', WClasses::IrregularVerbBe), 0) ; end
      literal2var('what', 'what')
      literal2var('when', 'when', '_')
      literal2var('who', 'who')
      literal2var('with', 'with')
      literal2var('word', 'words')
      def x_as_noun ; Lex::Literal.new('X', get_lexeme('X'), 0) ; end
      literal2var('you', 'you')

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

      context 'Producing parse tree or forest:' do
        it 'should produce trees (for non ambiguous input)' do
          # OK, non-ambiguous sentence: "Lisa sees Tony."
          literals = [lisa, sees, tony, dot]
          result_type = Rley::PTree::ParseTree
          expect(subject.to_ptree(literals)).to be_kind_of(result_type)
        end

        it 'should produce forest' do
          # Sentence: "Lisa sees Tony."
          literals = [lisa, sees, tony, dot]
          result_type = Rley::SPPF::ParseForest
          expect(subject.to_pforest(literals)).to be_kind_of(result_type)
        end
      end # context

      context 'Parsing lessons:' do
        it 'should parse sample sentences from lesson 1-A' do
          # Sentence 1-01: "Tony sees Lisa."
          # in absence of a tokenizer, we create a sequence of literals by hand...
          # prox_tony = ZProxy.new(tony)
          literals = [tony, sees, lisa, dot]
          expect { subject.to_ptree(literals) }.not_to raise_error

          # Sentence 1-02a: "Tony sees something."
          sentence_literals = [tony, sees, something, dot]
          expect { subject.to_ptree(sentence_literals) }.not_to raise_error

          # Sentence 1-02b: "Lisa sees something."
          sentence_literals = [lisa, sees, something, dot]
          expect { subject.to_ptree(sentence_literals) }.not_to raise_error

          # Sentence 1-03: "Tony sees this thing."
          sentence_literals = [tony, sees, this, thing, dot]
          expect { subject.to_ptree(sentence_literals) }.not_to raise_error

          # Sentence 1-04: "Lisa sees the other thing."
          sentence_literals = [lisa, sees, the, other, thing, dot]
          expect { subject.to_ptree(sentence_literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 1-B' do
          # Sentence 1-05a: "Lisa sees the same thing."
          literals = [lisa, sees, the, same, thing, dot]
          expect { subject.to_ptree(literals) }.not_to raise_error

          # Sentence 1-05b: "Lisa sees the same thing as Tony sees."
          literals = [lisa, sees, the, same, thing, as, tony, sees, dot]
          # same is an adjective of equality comparison
          # as is part of same ... as combination
          # it introduces a comparative clause
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-06: "Tony sees one thing."
          literals = [tony, sees, one, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-07: "Lisa sees two things."
          literals = [lisa, sees, two, things, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-08a: "Tony sees one person."
          literals = [tony, sees, one, person, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-08b: "Lisa sees two people."
          literals = [lisa, sees, two, people, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-05b: "Tony sees the same person as Lisa sees."
          literals = [tony, sees, the, same, person, as, lisa, sees, dot]
          # same is an adjective of equality comparison
          # as is part of same ... as combination
          # it introduces a comparative clause
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 1-C' do
          # Sentence 1-09a: "Tony sees many things."
          literals = [tony, sees, many, things, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-09b: "Lisa sees many people."
          literals = [lisa, sees, many, people, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-10: "Tony is inside this thing."
          literals = [tony, is, inside, this, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-11: "Lisa is not inside this thing."
          literals = [lisa, is, not_, inside, this, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence: "Lisa does not see people inside the other thing."
          literals = [lisa, does_aux, not_, see, people, inside, the, other, thing, dot]
          # Ambiguous parse...
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 1-D' do
          # Sentence 1-12a: "Some of these people are inside this thing."
          literals = [some, of, these, people, are, inside, this, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-12b: "Some of these people are not inside this thing."
          literals = [some, of, these, people, are, not_, inside, this, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-13: "All of these people are inside this thing."
          literals = [all, of, these, people, are, not_, inside, this, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-14a: "There are two people inside one of these things."
          literals = [there, are, two, people, inside, one, of, these, things, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-14b: "There are not people inside the other thing."
          literals = [there, are, not_, people, inside, the, other, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-15a: "There are many people inside this thing."
          literals = [there, are, many, people, inside, this, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-15b: "There are more people inside this thing."
          literals = [there, are, more, people, inside, this, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-15c: "There are more people inside the other thing
          # than there are inside this thing."
          literals = [there, are, more, people, inside, the, other, thing,
                      than, there, are, inside, this, thing, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 1-E' do
          # Sentence 1-16a: "Two of these things are alive."
          literals = [two, of, these, things, are, alive, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-16b: "One of these things is not alive."
          literals = [one, of, these, things, is, not_, alive, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-17a: "Tony sees some living things."
          literals = [tony, sees, some, living, things, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-17b: "Two of these things are big."
          literals = [two, of, these, things, are, big, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-17c: "One of these things is not big."
          literals = [one, of, these, things, is, not_, big, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-18a: "Tony sees some living things."
          literals = [tony, sees, some, living, things, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-18b: "One of these is big."
          literals = [one, of, these_as_pronoun, is, big, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-18c: "Two of these are small."
          literals = [two, of, these_as_pronoun, are, small, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-19a: "Tony sees one living thing."
          literals = [tony, sees, one, living, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-19b: "This one is very big."
          literals = [this_one, is, very, big, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence: "This thing is bigger than the other thing."
          literals = [this, thing, is, bigger, than, the, other, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence: "This thing is smaller than the other thing."
          literals = [this, thing, is, smaller, than, the, other, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 1-F' do
          # Sentence 1-20a: "Tony sees some living things."
          literals = [tony, sees, some, living, things, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-20b: "Two of these are the same kind of living thing."
          literals = [these_as_pronoun, are, the, same, kind, of, living, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-20c: "One of these is not the same kind as the other two."
          literals = [one, of, these_as_pronoun, is, not_, the, same, kind,
            as, the, other, two_as_pronoun, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-21a: "There is one person inside this thing."
          literals = [there, is, one, person, inside, this, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-21b: "If Tony is not inside this thing, then another person is inside."
          literals = [if_, tony, is, not_, inside, this, thing, comma, then_,
            another, person, is, inside, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-22a: "Tony is touching something."
          literals = [tony, is_aux, touching, something, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-22b: "Lisa is touching Tony."
          literals = [lisa, is_aux, touching, tony, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-23a: "Tony is far from Lisa."
          literals = [tony, is, far, from, lisa, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-23b: "Lisa is far from Tony."
          literals = [lisa, is, far, from, tony, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-23c: "Tony is not far from Lisa."
          literals = [tony, is, far, from, lisa, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-24: "Tony is near to Lisa."
          literals = [tony, is, near_to, lisa, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 1-G' do
          # Sentence 1-25a: "Lisa is in this place."
          literals = [lisa, is, in_, this, place, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-25b: "There are two other things in this place."
          literals = [there, are, two, other, things, in_, this, place, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-25c: "Lisa is in the same place as these two other things."
          literals = [lisa, is, in_, the, same, place, as, these, two, other, things, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-25d: "Tony is not in this place."
          literals = [tony, is, not_, in_, this, place, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-25e: "Tony is in another place."
          literals = [tony, is, in_, another, place, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-26a: "Lisa is inside this thing."
          literals = [lisa, is, inside, this, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-26b: "Tony is above this thing."
          literals = [tony, is, above, this, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-26c: "Tony is above lisa."
          literals = [tony, is, above, lisa, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-27a: "Tony is on one side of this thing."
          literals = [tony, is, on, one, side, of, this, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-27b: "Lisa is on the other side."
          literals = [lisa, is, on, the, other, side, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-27c: "Tony is touching one side of this thing."
          literals = [tony, is_aux, touching, one, side, of, this, thing, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 1-H' do
          # Sentence 1-28: "Tony hears something."
          literals = [tony, hears, something, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-29a: "Tony says something."
          literals = [tony, says, something, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-29b: "Tony says something to Lisa."
          literals = [tony, says, something, to, lisa, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-29c: "Tony says something about this living thing."
          literals = [tony, says, something, about, this, living, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-29d: 'Tony says: "This living thing is small."'
          literals = [tony, says, colon, quote, this, living, thing, is, small, dot, quote, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-30a: "Tony says some words."
          literals = [tony, says, some, words, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-30b: "Lisa says more words."
          literals = [lisa, says, more, words, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-31a: 'Tony says: "There are two people inside this thing."'
          literals = [tony, says, colon, quote, there, are, two, people, inside,
            this, thing, dot, quote, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-31b: 'Lisa says: "There is one person inside this thing."'
          literals = [lisa, says, colon, quote, there, is, one, person, inside,
            this, thing, dot, quote, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-31c: "What Tony says is not true."
          literals = [what, tony, says, is, not_, true_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 1-31d: "What Lisa says is true."
          literals = [what, lisa, says, is, true_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 2-A' do
          # Sentence 2-01a: "This thing is like two of the other things."
          literals = [this, thing, is, like, two, of, the, other, things, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-01b: "One of these things is not like the other things."
          literals = [one, of, these, things, is, not_, like, the, other, things, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-02a: "Lisa has something."
          literals = [lisa, has, something, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-02b: "Tony has another thing."
          literals = [tony, has, another, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-02c: "Lisa does not have the same kind of thing as Tony has."
          literals = [lisa, does_aux, not_, have, the, same, kind, of, thing, as, tony, has, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-03a: "Lisa is touching part of this thing."
          literals = [lisa, is_aux, touching, part, of, this, thing, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-03b: "Tony is touching the other part."
          literals = [tony, is_aux, touching, the, other, part, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-Ax: "What Tony has is like what Lisa has."
          literals = [what, tony, has, is, like, what, lisa, has, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 2-B' do
          # Sentence 2-04a: "Lisa does something."
          literals = [lisa, does, something, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-04b: "Lisa does something with this thing."
          literals = [lisa, does, something, with, this, thing, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-04c: "Lisa does something to Tony."
          literals = [lisa, does, something, to, tony, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-04d: "Lisa does something to Tony with this thing."
          literals = [lisa, does, something, to, tony, with, this, thing, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-05a: "Something happens."
          literals = [something, happens, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-05b: "Something happens to Lisa."
          literals = [something, happens, to, lisa, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-06a: "Tony does something."
          literals = [tony, does, something, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-06b: "Something happens to Lisa because of this."
          literals = [something, happens, to, lisa, because, of, this_as_pronoun, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-06c: "Something happens to Lisa because Tony does this."
          literals = [something, happens, to, lisa, because, tony, does, this_as_pronoun, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-06: "Something happens to this living thing."
          literals = [something, happens, to, this, living, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 2-C' do
          # Sentence 2-07a: "Lisa thinks Tony is inside this thing."
          literals = [lisa, thinks, tony, is, inside, this, thing, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-07b: "Lisa thinks something about Tony."
          literals = [lisa, thinks, something, about, tony, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-08a: "Tony knows Lisa is inside this thing, because Tony sees Lisa inside."
          literals = [tony, knows, lisa, is, inside, this, thing, comma,
            because, tony, sees, lisa, inside, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-08b: "Tony knows something about Lisa."
          literals = [tony, knows, something, about, lisa, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-09a: "Tony wants this thing."
          literals = [tony, wants, this, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-09b: "Tony wants to have this thing."
          literals = [tony, wants, to, have, this, thing, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-10a: "Tony wants to do something."
          literals = [tony, wants, to, do_, something, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-10b: "Lisa wants to do the same thing."
          literals = [lisa, wants, to, do_, the, same, thing, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-10c: "Tony can do this."
          literals = [tony, can, do_, this_as_pronoun, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-10d: "This is not something Lisa can do."
          literals = [this_as_pronoun, is, not_, something, lisa, can, do_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-10e: "Lisa cannot do this."
          literals = [lisa, can, not_, do_, this_as_pronoun, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 2-D' do
          # Sentence 2-11a: "This person does something bad."
          literals = [this, person, does, something, bad, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-11b: "This person does something bad for Tony."
          literals = [this, person, does, something, bad, for_, tony, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-12a: "Tony does something good."
          literals = [tony, does, something, good, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-12b: "Tony does something good for Lisa."
          literals = [tony, does, something, good, for_, lisa, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-13a: "Tony feels something."
          literals = [tony, feels, something, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-13b: "This does not feel good for Tony."
          literals = [this_as_pronoun, does_aux, not_, feel, good, for_, tony, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-13b: "This feels bad for Tony."
          literals = [this_as_pronoun, feels, bad, for_, tony, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-Dx: "Lisa thinks about something bad happening to this
          # living thing. Thinking about this feels bad for Lisa."
          literals = [lisa, thinks, about, something, bad, happening, to, this,
            living, thing, dot,
            #thinking, about, this_as_pronoun, feels, bad,
            #for_, lisa, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 2-E' do
          # Sentence 2-14a: "Lisa says something at this time."
          literals = [lisa, says, something, at, this, time, dot]
          # Ambiguous parse
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-14b: "Tony is not in this place at this time."
          literals = [tony, is, not_, in_, this, place, at, this, time, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-15a: "At one time, Tony does something to this thing."
          literals = [at, one, time, comma, tony, does, something, to, this, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-15b: "At another time, Lisa says something."
          literals = [at, another, time, comma, lisa, says, something, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-15c: "Tony does something to this thing before Lisa says something."
          literals = [tony, does, something, to, this, thing, before, lisa, says, something, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-16a: "Lisa does something for a long time."
          literals = [lisa, does, something, for_, a_as_art, long, time, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-17a: "Tony does something for a short time."
          literals = [tony, does, something, for_, a_as_art, short, time, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-17a: "Tony does not do this for a long time."
          literals = [tony, does_aux, not_, do_, this_as_pronoun, for_, a_as_art, long, time, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-18a: "Lisa sees something move."
          literals = [lisa, sees, something, move, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-18a: "Lisa moves near to this thing."
          literals = [lisa, moves, near_to, this, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-E-Xa: "A short time before, Tony was far from Lisa."
          # Case of a time adverbial adjunct that is put in front position.
          literals = [a_as_art, short, time, before_adverb, comma, tony, was, far, from, lisa, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-E-Xa: "At this time, Tony is near to Lisa"
          literals = [at, this, time, comma, tony, is, near_to, lisa, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-E-Xa: "Tony is near to Lisa because Tony moved"
          # Case of a time adverbial adjunct that is put in front position.
          literals = [tony, is, near_to, lisa, because, tony, moved, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 2-F' do
          # Sentence 2-19a: 'Tony says: "I did X.".'
          literals = [tony, says, colon, quote, i_pronoun, did, x_as_noun, dot, quote, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-19a definiendum: 'Tony says: "I did X.".'
          literals = [tony, says, colon, quote, i_pronoun, did, x_as_noun, dot, quote, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-19a definiens: 'Tony says something about Tony. Tony says: Tony did X.'
          literals = [tony, says, something, about, tony, dot,
                      tony, says, colon, tony, did, x_as_noun, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-19a: 'Tony says: "I see Lisa.".'
          literals = [tony, says, colon, quote, i_pronoun, see, lisa, dot, quote, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-19b definiendum: 'Lisa says: "X happened to me.".'
          literals = [lisa, says, colon, quote, x_as_noun, happened, to, me, dot, quote, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-19b definiens: 'Lisa says something about Lisa. Lisa says: X happened to Lisa.'
          literals = [lisa, says, something, about, lisa, dot,
                      lisa, says, colon, x_as_noun, happened, to, lisa, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-19c: 'Lisa says: "Tony sees me."'
          literals = [lisa, says, colon, quote, tony, sees, me, dot, quote, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-20a definiendum: 'Tony says to Lisa: "I can see you.".'
          literals = [tony, says, to, lisa, colon, quote, i_pronoun, can, see, you, dot, quote, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-20a definiens: 'Tony says something about Lisa.
          # Tony says this to Lisa. Tony says: Tony can see Lisa.'
          literals = [tony, says, something, about, lisa, dot,
                      tony, says, this_as_pronoun, to, lisa, dot,
                      tony, says, colon, tony, can, see, lisa, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-20b: "I know you have something good."
          literals = [i_pronoun, know, you, have, something, good, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-20c: "I want you to do something good for me."
          literals = [i_pronoun, want, you, to, do_, something, good, for_, me, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-21a definiendum: 'Tony says: "X happens here.".'
          literals = [tony, says, colon, quote, x_as_noun, happens, here, dot, quote, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-21a definiens: "Tony is in a place. Tony says: X happens in this place."
          literals = [tony, is, in_, a_as_art, place, dot,
                      tony, says, colon, x_as_noun, happens, in_, this, place, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-21b: "Many people were here at one time."
          literals = [many, people, were, here, at, one, time, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-22a definiendum: 'Lisa says: "X happens now.".'
          literals = [lisa, says, colon, quote, x_as_noun, happens, now, dot, quote, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-22a definiens: 'Lisa says something at a time.
          #   Lisa says: X happens at this same time.'
          literals = [lisa, says, something, at, a_as_art, time, dot,
                      lisa, says, colon, x_as_noun, happens, at, this, time, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-22b: "There are not many people here now."
          literals = [there, are, not_, many, people, here, now , dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-Fa: "Lisa says to Tony: "I can see many living things here."."
          literals = [lisa, says, to, tony, colon, quote, i_pronoun,
                      can, see, many, living, things, here, dot, quote, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 2-G' do
          # Sentence 2-23a definiendum: 'Someone does X.'
          literals = [someone, does, x_as_noun, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-23a definiens: 'Something does X. This something can
          #   think like people think. This something can be one person.'
          literals = [something, does, x_as_noun, dot,
                      this, something, can, think, like, people, think, dot,
                      this, something, can, be_, a_as_art, person, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-23b: Someone said something to Tony.
          literals = [someone, said, something, to, tony, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-23c definiendum: 'J knows who did K.'
          literals = [j_, knows, who, did, k_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-23c definiens: J thinks about someone.
          # J knows this someone did K.
          literals = [j_, thinks, about, someone, dot,
            j_, knows, this, someone, did, k_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-23d: Tony knows who said something.
          literals = [tony, knows, who, said, something, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-24a definiendum: 'J happens after K happens.'
          literals = [j_, happens, after_, k_, happens, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-24a definiens: K happens before J happens.
          literals = [k_, happens, before, j_, happens, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-24b: After you do something for a long time,
          # you can know much more about this.
          literals = [after_, you, do_, something, for_, a_as_art, long, time,
            comma, you, can, know, much, more_as_adverb, about, this_as_pronoun, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-25a definiendum: 'X is true for some time.'
          literals = [x_as_noun, is, true_, for_, some, time, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-25a definiens: X is true at a time.
          #   Some parts of this one time happen before other parts.
          #   Some parts of this one time happen after other parts.
          #   X is true at all parts of this one time.
          literals = [x_as_noun, is, true_, at, a_as_art, time, dot,
            some, parts, of, this, one, time, happen, before_adverb, other, parts, dot,
            some, parts, of, this, one, time, happen, after_adverb, other, parts, dot,
            x_as_noun, is, true_, at, all, parts, of, this, one, time, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-25b: After I moved for some time,
          # I was near the other side of this place.
          literals = [after_, i_pronoun, moved, for_, some, time,
            comma, i_pronoun, was, near, the, other, side, of, this, place, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-26a definiendum: 'X happens in a moment.'
          literals = [x_as_noun, happens, in_, a_as_art, moment, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-26a definiens: X happens for one very short time.
          #   There are not parts of this very short time when one part
          #   happens before other parts.
          literals = [x_as_noun, happens, for_, one, very, short, time, dot,
            there, are, not_, parts, of, this, very, short, time, when_,
            one, part, happens, before_adverb, other, part, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-26b: In a moment, I knew something here was not good.
          # 'here' is adverb that modifies the 'knew' verb
          literals = [in_, a_as_art, moment, comma, i_pronoun, knew, something,
                      here, was, not_, good, dot ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-Gx: Tony is inside this thing for some time.
          # Lisa says: "I want to know who is inside this thing.".
          # Tony hears Lisa. Because of this, Tony says: "I am inside.".
          # Tony says this after Tony hears Lisa.
          literals = [tony, is, inside, this, thing, for_, some, time, dot,
            lisa, says, colon, quote, i_pronoun, want, to, know, who, is,
            inside, this, thing, dot, quote, dot,  tony, hears, lisa, dot,
            because, of, this_as_pronoun, comma, tony, says, colon,
            quote, i_pronoun, am, inside, dot, quote, dot,
            tony, says, this_as_pronoun, after_, tony, hears, lisa, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 2-H' do
          # Sentence 2-27a definiendum: 'X is the body of this person.'
          literals = [x_as_noun, is, the, body, of, this, person, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-27b "Parts of this person can touch other things.
          #  Parts of this person can touch other parts inside this person.
          #  X is all of these parts of this person."
          # [One part of the body of this person felt very bad.]
          literals = [ parts, of, this, person, can, touch, other, things, dot,
            parts, of, this, person, can, touch, other, parts, inside,
              this, person, dot,
            x_as_noun, is, all, of, these, parts, of, this, person, dot,
            one, part, of, the, body, of, this, person, felt, very, bad, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-28a definiendum "X dies."
          literals = [x_as_noun, dies, dot]
          expect { subject.to_ptree(literals) }.not_to raise_error

          # Sentence 2-28b definiens "Something happens to X in a moment.
          # X is alive before this moment. X is not alive after this moment.
          # [After this person lived for a long time, this person died."
          literals = [ something, happens, to, x_as_noun, in_, a_as_art,
              moment, dot,
            x_as_noun, is, alive, before_adverb, this, moment, dot,
            x_as_noun, is, not_, alive, after_adverb, this, moment, dot,
            after_, this, person, lived, for_, a_as_art, long, time, comma,
              this, person, died, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-29a definiendum "You think maybe X is true."
          literals = [you, think, maybe, x_as_noun, is, true_, dot]
          expect { subject.to_ptree(literals) }.not_to raise_error

          # Sentence 2-29b definiens "You think something like X
          # can be true. You do not know X is true.
          # You do not know X is not true.
          # [Maybe some people far from here can see me.]"
          literals = [  you, do_aux, not_, know, x_as_noun, is, true_, dot,
            you, do_aux, not_, know, x_as_noun, is, not_, true_, dot,
            maybe, some, people, far_from, here_as_noun, can, see, me, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-30a definiendum "J is below K."
          literals = [j_, is, below, k_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error
          
          # Sentence 2-30b definiens "K is above J.
          # [I am touching this thing below me.]
          literals = [  j_, is, below, k_, dot,
            i_pronoun, am, touching, this, thing, below, me, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-H extra "Someone sees this thing.
          #   The body of this thing is not moving.
          #   Maybe this thing is dead."
          literals = [ someone, sees, thing, dot,
            the, body, of, this, thing, is_aux, not_, moving, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error             
        end
=begin
TODO
Lesson 2.C

	Xtra:
		Tony knows Lisa has something, because Tony sees what Lisa has.
		Tony thinks about what Lisa has, because Tony want to have the same kind of thing.
=end
      end # context
    end # describe
  end # module
end # module
