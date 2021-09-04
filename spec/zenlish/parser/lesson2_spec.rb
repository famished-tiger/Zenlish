# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../support/var2word'
require_relative '../../../lib/zenlish/parser/zparser' # Load the class under test

module Zenlish
  module Parser
    describe ZParser do
      include Var2Word

      subject { ZParser.new }

      context 'Parsing lesson 2:' do
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
            living, thing, dot]
            # thinking, about, this_as_pronoun, feels, bad,
            # for_, lisa, dot]
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
          literals = [there, are, not_, many, people, here, now, dot]
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
            here, was, not_, good, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-Gx: Tony is inside this thing for some time.
          # Lisa says: "I want to know who is inside this thing.".
          # Tony hears Lisa. Because of this, Tony says: "I am inside.".
          # Tony says this after Tony hears Lisa.
          literals = [tony, is, inside, this, thing, for_, some, time, dot,
            lisa, says, colon, quote, i_pronoun, want, to, know, who, is,
            inside, this, thing, dot, quote, dot, tony, hears, lisa, dot,
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
          literals = [parts, of, this, person, can, touch, other, things, dot,
            parts, of, this, person, can, touch, other, parts, inside,
            this, person, dot,
            x_as_noun, is, all, of, these, parts, of, this, person, dot,
            one, part, of, the, body, of, this, person, felt, very, bad, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-28a definiendum "X dies."
          literals = [x_as_noun, dies, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-28b definiens "Something happens to X in a moment.
          # X is alive before this moment. X is not alive after this moment.
          # [After this person lived for a long time, this person died."
          literals = [something, happens, to, x_as_noun, in_, a_as_art,
            moment, dot,
            x_as_noun, is, alive, before_adverb, this, moment, dot,
            x_as_noun, is, not_, alive, after_adverb, this, moment, dot,
            after_, this, person, lived, for_, a_as_art, long, time, comma,
            this, person, died, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-29a definiendum "You think maybe X is true."
          literals = [you, think, maybe, x_as_noun, is, true_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-29b definiens "You think something like X
          # can be true. You do not know X is true.
          # You do not know X is not true.
          # [Maybe some people far from here can see me.]"
          literals = [you, do_aux, not_, know, x_as_noun, is, true_, dot,
            you, do_aux, not_, know, x_as_noun, is, not_, true_, dot,
            maybe, some, people, far_from, here_as_noun, can, see, me, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-30a definiendum "J is below K."
          literals = [j_, is, below, k_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-30b definiens "K is above J.
          # [I am touching this thing below me.]
          literals = [j_, is, below, k_, dot,
            i_pronoun, am, touching, this, thing, below, me, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 2-H extra "Someone sees this thing.
          #   The body of this thing is not moving.
          #   Maybe this thing is dead."
          literals = [someone, sees, thing, dot,
            the, body, of, this, thing, is_aux, not_, moving, dot]
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
