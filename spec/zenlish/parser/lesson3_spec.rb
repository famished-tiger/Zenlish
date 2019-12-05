# frozen_string_literal: true
require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../support/var2word'
require_relative '../../../lib/zenlish/parser/zparser' # Load the class under test

module Zenlish
  module Parser
    describe ZParser do
      include Var2Word

      subject { ZParser.new }

      context 'Parsing lesson 3:' do
        it 'should parse sample sentences from lesson 3-A' do
          # Sentence 3-01a definiendum: 'J happens to something that does K.'
          literals = [j_, happens, to, something, that, does, k_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-01b definiens: 'J happens to something.
          #   This same something does K.
          #   [Tony has something that Lisa wants.]'
          literals = [j_, happens, to, something, dot,
            this, same, thing, does, k_, dot,
            tony, has, something, that, lisa, wants, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-02a definiendum: 'J is true, and K is true.'
          literals = [j_, is, true_, comma, and_, k_, is, true_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-02b definiens: 'These two things are true: J is true.
          #   K is true.'
          #   [Lisa sees Tony, and Tony sees Lisa.]'
          literals = [these, two, things, are, true_, colon, j_, is, true_, dot,
            k_, is, true_, dot,
            lisa, sees, tony, comma, and_, tony, sees, lisa, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-02c definiendum: 'J and K do X.'
          literals = [j_, and_, k_, do_, x_as_noun, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-02d definiens: 'These two things do X.
          #   J is one that does this.
          #   K is another that does this.'
          #   [Tony and Lisa want to see me.]
          #   [I see Tony and Lisa.]'
          literals = [these, two, things, do_, x_as_noun, dot,
            j_, is, one_as_adj, that, does, this_as_pronoun, dot,
            k_, is, another, that, does, this_as_pronoun, dot,
            tony, and_, lisa, want, to, see, me, dot,
            i_pronoun, see, tony, and_, lisa, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-03a definiendum: 'J is true, or K is true.'
          literals = [j_, is, true_, comma, or_, k_, is, true_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-03b definiens: 'If J is not true, then K is true.
          # [Tony saw me, or Lisa heard me.]
          literals = [if_, j_, is, not_, true_, comma,
              then_, k_, is, true_, dot,
            tony, saw, me, comma, or_, lisa, heard, me, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-03c definiendum: 'J or K does this.'
          literals = [j_, or_, k_, does, this_as_pronoun, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-03d definiendum: 'If J does not do this, then K does this.'
          literals = [if_, j_, does_aux, not_, do_, this_as_pronoun, comma,
            then_, k_, does, this_as_pronoun, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-03e: '[Lisa or Tony said something.]
          # [This belongs to Tony or Lisa.]'
          literals = [lisa, or_, tony, said, something, dot,
            this_as_pronoun, belongs, to, tony, or_, lisa, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-04a definiendum: 'It does something.'
          literals = [it_, does, something, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-04b definiens: 'This thing does something.'
          # [I touched this thing, and it moved.]
          literals = [this, thing, does, something, dot,
            i_pronoun, touched, this, thing, comma, and_, it_, moved, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-04c definiendum: 'They do something.'
          literals = [they, does, something, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-04d definiens: 'These things or people do something.'
          # [Something happens to them.] = Something happens to these things or people.
          literals = [ these, things, or_, people, do_, something, dot,
            something, happens, to, them, dot,
            something, happens, to, these, things, or_, people, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 3-B' do
          # Sentence 3-05a definiendum: 'This is its X.'
          literals = [this_as_pronoun, is, its, x_as_noun, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-05b definiens: 'This X belongs to it.
          # [I saw this thing and touched some of its parts.]
          # [These things are their things.] = These things belong to them.
          literals = [this, x_as_noun, belongs, to, it_, dot,
            i_pronoun, saw, this, thing, and_, touched, some, of, its, parts, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-05c definiendum: 'These things are their things.'
          literals = [these, things, are, their, things, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-05d definiens: 'These things belong to them.
          literals = [these, things, belong, to, them, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-06a definiendum: 'This is your X.'
          literals = [this_as_pronoun, is, your, x_as_noun, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-06b definien: 'This X belongs to you.
          # [You feel something touching your body.]
          literals = [this, x_as_noun, belongs, to, you, dot,
            you, feel, something, touching, your, body, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-07a definiendum: 'This is my X.'
          literals = [this_as_pronoun, is, my, x_as_noun, dot,
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-07b definiens: 'This X belongs to me.
          # [I do not want you to touch my body.]
          literals = [this, x_as_noun, belongs, to, me, dot,
            i_pronoun, do_aux, not_, want, to, touch, my, body, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-08a definiendum: 'There is an X here.'
          literals = [there, is, an, x_as_noun, here, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-08b definiens: 'X is some kind of thing.
          # There is one of this kind of thing here.
          # This is not one that you said something about a short time before now.
          # [I did not know there was a person in this place.]
          literals = [x_as_noun, is, some, kind, of, thing, dot,
            there, is, one, of, this, kind, of, thing, here, dot,
            this_as_pronoun, is, not_, one_as_adj, that, you, said, something,
              about, a_as_art, short, time, before_as_adj, now_as_noun, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-Bxa 'Lisa sees a living thing that is very big.
          # Lisa says: "I see one living thing. Its body is bigger than my body.", dot
          literals = [
            lisa, sees, a_as_art, living, thing, that, is, very, big, dot,
            lisa, says, colon, quote, i_pronoun, see, one, living, thing, dot,
              its, body, is, bigger, than, my, body, dot, quote, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 3-C' do
          # Sentence 3-09a definiendum: 'Something happens to the X.'
          literals = [something, happens, to, the, x_as_noun, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-09b definiens: Something happens to X.
          # This is the same X that someone said something about a short time before,
          # or there is not another thing that is the same kind as X.
          # [I saw two people here before, and now I do not see the people.]
          literals = [something, happens, to, x_as_noun, dot,
            this_as_pronoun, is, the, same, x_as_noun, that, someone, said, something, about,
              a_as_art, short, time, before_as_adj, comma,
              or_, there, is, not_, another, thing, that, is, the, same, kind,
                as, x_as_noun, dot,
            i_pronoun, saw, two, people, here, before_adverb, comma,
              and_, now, i_pronoun, do_aux, not_, see, the, people, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-10a definiendum: 'X is an animal.'
          literals = [x_as_noun, is, an, animal, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-10b definiens: There are many kinds of living things
          #   that can feel and can move when they want. X is one of these.
          #   [The animal moved when someone touched its body.]
          literals = [ there, are, many, kinds, of, living, things,
              that, can, feel, and_, can, move, when_, they, want, dot,
              x_as_noun, is, one, of, these_as_pronoun, dot,
              the, animal, moved, when_, someone, touched, its, body, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-11a definiendum: 'J causes K to happen.'
          literals = [j_, causes, k_, to, happen, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-11b definiens: K happens because J happens
          #   or because J does something.
          #   [Someone bad caused these people to die.]
          literals = [ k_, happens, because, j_, happens,
            or_, because, j_, does, something, dot,
            something, bad, caused, these, people, to, die, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-12a definiendum: 'J is true, but K is not true.'
          literals = [j_, is, true_, comma, but, k_, is, not_, true_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-12b definiens: You say J is true.
          # Maybe when some people hear J is true,
          #   they think K is true because of this.
          # You want them to know K is not true, and you say this.
          # [I hear Tony, but I do not see Tony.]
          literals = [ maybe, when_, some, people, hear, j_, is, true_, comma,
              they, think, k_, is, true_, because, of, this_as_pronoun, dot,
            you, want, them, to, know, k_, is, not_, true_, comma,
            and_, you, say, this_as_pronoun, dot,
            i_pronoun, hear, tony, comma, but, i_pronoun, do_aux, not_, see, lisa, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-C Xtra Lisa says: "I can hear an animal, but I do not see it."
          # Tony says: "I can see the animal that you hear.".
          literals = [ lisa, says, colon, quote, i_pronoun, can, hear, an,
              animal, comma, but, i_pronoun, do_aux, not_, see, it_, dot, quote,
            dot, tony, says, colon, quote, i_pronoun, can, see, the, animal,
              that, you, hear, dot, quote, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 3-D' do
          # Sentence 3-13a definiendum: 'You use this thing.'
          literals = [you, use, this, thing, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-13b definiens: You do something with this thing
          # because you think this can cause something to happen that you want.
          # [I used something big to cause people far from here to see me.]
          literals = [ you, do_, something, with, this, thing, because, you,
            think, this_as_pronoun, can, cause, something, to, happen,
            that, you, want, dot,
            i_pronoun, used, something, big, to, cause, people, far, from,
            here_as_noun, to, see, me, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-14a definiendum: 'You know X about each of these things.'
          literals = [you, know, x_as_noun, about, each_, of, these, things, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-14b definiens: There are two or more things.
          # You think about all these things like this:
          # If something is one of these things, then you know X about it.
          # [Each person here said something to me.]
          # because you think this can cause something to happen that you want.
          # [I used something big to cause people far from here to see me.]
          literals = [ there, are, two, or_, more, things, dot,
            you, think, about, all, these, things, like, this_as_pronoun, colon,
              if_, something, is, one, of, these, things, comma,
              then_, you, know, x_as_noun, about, it_, dot,
            each_, person, here, said, something, to, me, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-15a definiendum: 'Someplace an X exists.'
          literals = [someplace, an, x_as_noun, exists, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-15b definiens: Someplace there is an X,
          # or someplace an X is alive.
          # [This kind of thing did not exist before this time.]
          literals = [ someplace, there, is, an, x_as_noun, comma,
            or_, someplace, an, x_as_noun, is, alive, dot,
            this, kind, of, thing, did, not_, exist, before, this, time, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-16a definiendum: 'J became K.'
          literals = [j_, became, k_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-16b definiens: Something happened to J for some time.
          # After this happened, K is something true you can know about J.
          # But before this happened, K was not true.
          # [These two animals were small before, but they became big.]
          literals = [ something, happened, to, j_, for_, some, time, dot,
            after_, this_as_pronoun, happened, comma, k_, is, something, true_,
              you, can, know, about, j_, dot,
            these, two, animals, were, small, before_adverb, comma,
            but, they, became, big, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-Dx: There are some animals here.
          # Each of these animals was small when it existed a short time.
          # After a long time, each of these animals became big.
          literals = [there, are, some, animal, here, dot,
            each_, of, these, animals, was, small, when_, it_,
              existed, a_as_art, short, time, dot,
            after_, a_as_art, long, time, comma, each_, of, these, animals,
              became, big, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 3-E' do
          # Sentence 3-17a definiendum: 'These things are different.'
          literals = [things, are, different, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-17b definiens: These things are not the same.
          # [I want this kind of thing, but you want something different.]
          literals = [ these, things, are, not_, the, same_as_pronoun, dot,
            i_pronoun, want, this, kind, of, thing, comma,
            but, you, want, something, different, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-18a definiendum: 'J made K.'
          literals = [j_, made, k_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-18b definiens: J did something to some things
          # and caused them to become parts of one different
          # kind of thing that was not here before.
          # K is this thing that now exists because of this.
          # [I used many small things to make this big thing.]
          # [J made K happen.] = J caused K to happen.
          literals = [ j_, did, something, to, some, things, and_,
            caused, them, to, become, parts, of, one, different, kind, of,
            thing, that, was, not_, here, before_adverb, dot,
            k_, is, this, thing, that, now, exists, because, of, this_as_pronoun, dot,
            i_pronoun, used, many, small, things, to, make, this, big, thing, dot,
            j_, made, k_, happen, dot,
            j_, caused, k_, to, happen, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-19a definiendum: 'J contains K.'
          literals = [j_, contains, k_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-19b definiens: K is inside J.
          # [I made something to contain all these small things.]
          # [Your body contains many parts.]
          literals = [ k_, is, inside, j_, dot,
            i_pronoun, made, something, to, contain, all, these, small, things, dot,
            your, body, contains, many, parts, dot,
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-20a definiendum: 'X is a container.'
          literals = [x_as_noun, is, a_as_art, container, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-20b definiens: X is something that people make because
          # they want to use it to contain other things.
          # [There are two things inside this container.]
          literals = [ x_as_noun, is, something, that, people, make, because,
            they, want, to, use, it_, to, contain, other, things, dot,
            there, are, two, things, inside, this, container, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-Extra: Someone made these containers.
          # Each contains a different kind of animal.
          literals = [someone, made, these, containers, dot,
            each_as_pronoun, contains, a_as_art, different, kind, of, animal, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 3-F' do
          # Sentence 3-21a definiendum: 'You try to do X.'
          literals = [you, try_, to, do_, x_as_noun, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-21b definiens: Because you want X to happen,
          # you do things that you think can cause X to happen.
          # [I tried to do something good.]
          literals = [ because, you, want, x_as_noun, to, happen, comma,
            you,  do_, things, that, you, think, can, cause, x_as_noun,
            to, happen, dot,
            i_pronoun, tried, to, do_, something, good, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-22a definiendum: 'X changed.'
          literals = [x_as_noun, changed, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-22b definiens: Something happened to X.
          # Because of this, X is not the same as before.
          # [After this kind of animal is alive for some time, its body changes.]
          literals = [ something, happened, to, x_as_noun, dot,
            because, of, this_as_pronoun, comma, x_as_noun, is, not_, the, same_as_pronoun,
            as, before_adverb, dot,
            after_, this, kind, of, animal, is, alive, for_, some, time, comma,
              its, body, changes, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-22c definiendum: 'J changed K.'
          literals = [j_, changed, k_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-22d definiens: J caused K to change.
          # Because of this, X is not the same as before.
          # [When these people did something bad, it changed what I thought about them.]
          literals = [ j_, caused, k_, to, change_, dot,
            when_, these, people, did, something, bad, comma,
            it_, changed, what, i_pronoun, thought, about, them, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-23a definiendum: 'You see the surface of X.'
          literals = [you, see, the, surface, of, x_as_noun, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-23b definiens: You see part of X.
          # This part is where other things can touch X.
          # [I can see the surface of this thing, but I cannot see what is inside.]
          # [When I touched this thing, I could feel parts of it moving below its surface.]
          # comment: `where` word was implicitly defined in section 1-25.
          # `could` verb was implicitly defined in section 2-10.
          literals = [ i_pronoun, can, see, the, surface, of, this, thing, comma,
            but, i_pronoun, can, not_, see, what, is, inside, dot,
            when_, i_pronoun, touched, this, thing, comma, i_pronoun, could,
              feel, parts, of, it_, moving, below, its, surface, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-23c definiendum: 'J is on the surface of K.'
          literals = [j_, is, on, the, surface, of, k_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-23d definiens: J is touching the surface of K.
          literals = [ j_, is, touching, the, surface, of, k_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-F xtra: Tony wants to know what is inside this container.
          # Tony tries to touch things inside the container.
          literals = [ tony, wants, to, know, what, is, inside, this, container, dot,
            tony, tries, to, touch, things, inside, the, container, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end

        it 'should parse sample sentences from lesson 3-G' do
          # Sentence 3-24a definiendum: 'You choose one of these things.'
          literals = [you, choose, one, of, these, things, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-24b definiendum: 'There are two or more things you can do.
          # If you do one of these, you cannot do another.
          # You think about these and what you want to do.
          # There is one moment when you know what one of these you want more,
          #   and after this moment, you try for some time to do this one.
          # [You can choose to have one of these things.]
          # [I chose this big one.]'
          literals = [there, are, two, or_, more, things, you, can, do_, dot,
            if_, you, do_, one, of, these_as_pronoun, comma,
              you, can, not_, do_, another_as_pronoun, dot,
            you, think, about, these_as_pronoun, and_,
              what, you, want, to, do_, dot,
            there, is, one, moment, when_, you, know, what, one, of, these_as_pronoun,
              you, want, more_as_adverb, comma, and_,
              after_adverb, this, moment, comma, you, try_, for_, some, time,
              to, do_, this, one_as_pronoun, dot,
              you, can, choose, to, have, one, of, these, things, dot,
              i_pronoun, chose, this, big, one_as_pronoun, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-25a definiendum: 'X is in a place between J and K.'
          literals = [x_as_noun, is, in_, a_as_art, place, between, j_, and_, k_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-25b definiens: X is in a place.
          # J is on one side of X, and K is on the other side of X.
          literals = [x_as_noun, is, in_, a_as_art, place, dot,
            j_, is, on, one, side, of, x_as_noun, comma, and_,
            k_, is, on, the, other, side, of, x_as_noun, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-25c definiendum: 'X happens at a time between J and K.'
          literals = [x_as_noun, happens, at, a_as_art, time, between, j_, and_, k_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-25d definiens: X happens after J and before K
          literals = [x_as_noun, happens, after_as_prep, j_, and_,
            before_as_prep, k_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-25e definiendum: 'X is between J and K.'
          literals = [x_as_noun, is, between, j_, and_, k_, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-25f definiens: X is more than J but not more than K.
          literals = [x_as_noun, is, more, than, j_,
            but, not_, more, than, k_, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-26a definiendum: 'X moved here from this other place.'
          literals = [x_as_noun, moved, here, from, this, other, place, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-26b definiens: 'X was in this other place before
          #   it moved for some time. Because X moved, it is here after this,
          #   and it is not in this other place.'
          literals = [x_as_noun, was, in_, this, other, place, before,
            it_, moved, for_, some, time, dot,
            because, x_as_noun, moved, comma, it_, is, here, after_,
            this_as_pronoun, comma, and_, it_, is, not_, in_, this, other, place, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-27a definiendum: 'X is a machine.'
          literals = [x_as_noun, is, a_as_art, machine, dot]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-27b definiens: 'X is something people make.
          # When people make some things like X, they use many parts to make these things.
          # Some parts of X move. Some parts can cause other parts to move.
          # People make things like this because these things do something that people want.
          # These things can do more than people can do and more than people want to do.
          # [I used a machine to cause these big things to move.].'
          literals = [x_as_noun, is, something, people, make, dot,
            when_, people, make, some, things, like, x_as_noun, comma,
              they, use, many, parts, to, make, these, things, dot,
            some, parts, of, x_as_noun, move, dot,
            some, parts, can, cause, other, parts, to, move, dot,
            people, make, things, like, this_as_pronoun, because, these, things, do_,
              something, that, people, want, dot,
            these, things, can, do_, more_as_adverb, than, people, can, do_,
              and_, more_as_adverb, than, people, want, to, do_, dot,
            i_pronoun, used, a_as_art, machine, to, cause, these, big, things,
              to, move, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error

          # Sentence 3-G xtra: Tony wants to make something using a machine.
          # Tony is between two different machines.
          # Tony says: "I can choose to use one of these machines."
          literals = [ tony, wants, to, make, something, using, a_as_art,
            machine, dot,
            tony, is, between, two, different, machines, dot,
            tony, says, colon, quote, i_pronoun, can, choose, to, use,
              one, of, these, machines, dot, quote, dot
          ]
          expect { subject.to_pforest(literals) }.not_to raise_error
        end
      end # context
    end # describe
  end # module
end # module
