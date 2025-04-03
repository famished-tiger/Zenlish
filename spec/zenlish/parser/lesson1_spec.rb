# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../support/var2word'
require_relative '../../../lib/zenlish/parser/zparser' # Load the class under test

module Zenlish
  module Parser
    describe ZParser do
      include Var2Word

      subject(:parser) { described_class.new }

      context 'Parsing lesson 1:' do
        it 'parses sample sentences from lesson 1-A' do
          # Sentence 1-01: "Tony sees Lisa."
          # in absence of a tokenizer, we create a sequence of literals by hand...
          literals = [tony, sees, lisa, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-02a: "Tony sees something."
          sentence_literals = [tony, sees, something, dot]
          expect { parser.to_pforest(sentence_literals) }.not_to raise_error

          # Sentence 1-02b: "Lisa sees something."
          sentence_literals = [lisa, sees, something, dot]
          expect { parser.to_pforest(sentence_literals) }.not_to raise_error

          # Sentence 1-03: "Tony sees this thing."
          sentence_literals = [tony, sees, this, thing, dot]
          expect { parser.to_pforest(sentence_literals) }.not_to raise_error

          # Sentence 1-04: "Lisa sees the other thing."
          sentence_literals = [lisa, sees, the, other, thing, dot]
          expect { parser.to_pforest(sentence_literals) }.not_to raise_error
        end

        it 'parses sample sentences from lesson 1-B' do
          # Sentence 1-05a: "Lisa sees the same thing."
          literals = [lisa, sees, the, same, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-05b: "Lisa sees the same thing as Tony sees."
          literals = [lisa, sees, the, same, thing, as, tony, sees, dot]
          # same is an adjective of equality comparison
          # as is part of same ... as combination
          # it introduces a comparative clause
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-06: "Tony sees one thing."
          literals = [tony, sees, one, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-07: "Lisa sees two things."
          literals = [lisa, sees, two, things, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-08a: "Tony sees one person."
          literals = [tony, sees, one, person, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-08b: "Lisa sees two people."
          literals = [lisa, sees, two, people, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-05b: "Tony sees the same person as Lisa sees."
          literals = [tony, sees, the, same, person, as, lisa, sees, dot]
          # same is an adjective of equality comparison
          # as is part of same ... as combination
          # it introduces a comparative clause
          expect { parser.to_pforest(literals) }.not_to raise_error
        end

        it 'parses sample sentences from lesson 1-C' do
          # Sentence 1-09a: "Tony sees many things."
          literals = [tony, sees, many, things, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-09b: "Lisa sees many people."
          literals = [lisa, sees, many, people, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-10: "Tony is inside this thing."
          literals = [tony, is, inside, this, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-11: "Lisa is not inside this thing."
          literals = [lisa, is, not_, inside, this, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence: "Lisa does not see people inside the other thing."
          literals = [lisa, does_aux, not_, see, people, inside, the, other, thing, dot]
          # Ambiguous parse...
          expect { parser.to_pforest(literals) }.not_to raise_error
        end

        it 'parses sample sentences from lesson 1-D' do
          # Sentence 1-12a: "Some of these people are inside this thing."
          literals = [some, of, these, people, are, inside, this, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-12b: "Some of these people are not inside this thing."
          literals = [some, of, these, people, are, not_, inside, this, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-13: "All of these people are inside this thing."
          literals = [all, of, these, people, are, not_, inside, this, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-14a: "There are two people inside one of these things."
          literals = [there, are, two, people, inside, one, of, these, things, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-14b: "There are not people inside the other thing."
          literals = [there, are, not_, people, inside, the, other, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-15a: "There are many people inside this thing."
          literals = [there, are, many, people, inside, this, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-15b: "There are more people inside this thing."
          literals = [there, are, more, people, inside, this, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-15c: "There are more people inside the other thing
          # than there are inside this thing."
          literals = [there, are, more, people, inside, the, other, thing,
            than, there, are, inside, this, thing, dot]
          # Ambiguous parse
          expect { parser.to_pforest(literals) }.not_to raise_error
        end

        it 'parses sample sentences from lesson 1-E' do
          # Sentence 1-16a: "Two of these things are alive."
          literals = [two, of, these, things, are, alive, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-16b: "One of these things is not alive."
          literals = [one, of, these, things, is, not_, alive, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-17a: "Tony sees some living things."
          literals = [tony, sees, some, living, things, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-17b: "Two of these things are big."
          literals = [two, of, these, things, are, big, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-17c: "One of these things is not big."
          literals = [one, of, these, things, is, not_, big, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-18a: "Tony sees some living things."
          literals = [tony, sees, some, living, things, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-18b: "One of these is big."
          literals = [one, of, these_as_pronoun, is, big, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-18c: "Two of these are small."
          literals = [two, of, these_as_pronoun, are, small, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-19a: "Tony sees one living thing."
          literals = [tony, sees, one, living, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-19b: "This one is very big."
          literals = [this_one, is, very, big, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence: "This thing is bigger than the other thing."
          literals = [this, thing, is, bigger, than, the, other, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence: "This thing is smaller than the other thing."
          literals = [this, thing, is, smaller, than, the, other, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error
        end

        it 'parses sample sentences from lesson 1-F' do
          # Sentence 1-20a: "Tony sees some living things."
          literals = [tony, sees, some, living, things, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-20b: "Two of these are the same kind of living thing."
          literals = [these_as_pronoun, are, the, same, kind, of, living, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-20c: "One of these is not the same kind as the other two."
          literals = [one, of, these_as_pronoun, is, not_, the, same, kind,
            as, the, other, two_as_pronoun, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-21a: "There is one person inside this thing."
          literals = [there, is, one, person, inside, this, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-21b: "If Tony is not inside this thing, then another person is inside."
          literals = [if_, tony, is, not_, inside, this, thing, comma, then_,
            another, person, is, inside, dot]
          # Ambiguous parse
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-22a: "Tony is touching something."
          literals = [tony, is_aux, touching, something, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-22b: "Lisa is touching Tony."
          literals = [lisa, is_aux, touching, tony, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-23a: "Tony is far from Lisa."
          literals = [tony, is, far, from, lisa, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-23b: "Lisa is far from Tony."
          literals = [lisa, is, far, from, tony, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-23c: "Tony is not far from Lisa."
          literals = [tony, is, far, from, lisa, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-24: "Tony is near to Lisa."
          literals = [tony, is, near_to, lisa, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error
        end

        it 'parses sample sentences from lesson 1-G' do
          # Sentence 1-25a: "Lisa is in this place."
          literals = [lisa, is, in_, this, place, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-25b: "There are two other things in this place."
          literals = [there, are, two, other, things, in_, this, place, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-25c: "Lisa is in the same place as these two other things."
          literals = [lisa, is, in_, the, same, place, as, these, two, other, things, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-25d: "Tony is not in this place."
          literals = [tony, is, not_, in_, this, place, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-25e: "Tony is in another place."
          literals = [tony, is, in_, another, place, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-26a: "Lisa is inside this thing."
          literals = [lisa, is, inside, this, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-26b: "Tony is above this thing."
          literals = [tony, is, above, this, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-26c: "Tony is above lisa."
          literals = [tony, is, above, lisa, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-27a: "Tony is on one side of this thing."
          literals = [tony, is, on, one, side, of, this, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-27b: "Lisa is on the other side."
          literals = [lisa, is, on, the, other, side, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-27c: "Tony is touching one side of this thing."
          literals = [tony, is_aux, touching, one, side, of, this, thing, dot]
          # Ambiguous parse
          expect { parser.to_pforest(literals) }.not_to raise_error
        end

        it 'parses sample sentences from lesson 1-H' do
          # Sentence 1-28: "Tony hears something."
          literals = [tony, hears, something, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-29a: "Tony says something."
          literals = [tony, says, something, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-29b: "Tony says something to Lisa."
          literals = [tony, says, something, to, lisa, dot]
          # Ambiguous parse
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-29c: "Tony says something about this living thing."
          literals = [tony, says, something, about, this, living, thing, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-29d: 'Tony says: "This living thing is small."'
          literals = [tony, says, colon, quote, this, living, thing, is, small, dot, quote, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-30a: "Tony says some words."
          literals = [tony, says, some, words, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-30b: "Lisa says more words."
          literals = [lisa, says, more, words, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-31a: 'Tony says: "There are two people inside this thing."'
          literals = [tony, says, colon, quote, there, are, two, people, inside,
            this, thing, dot, quote, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-31b: 'Lisa says: "There is one person inside this thing."'
          literals = [lisa, says, colon, quote, there, is, one, person, inside,
            this, thing, dot, quote, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-31c: "What Tony says is not true."
          literals = [what, tony, says, is, not_, true_, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error

          # Sentence 1-31d: "What Lisa says is true."
          literals = [what, lisa, says, is, true_, dot]
          expect { parser.to_pforest(literals) }.not_to raise_error
        end
      end # context
    end # describe
  end # module
end # module
