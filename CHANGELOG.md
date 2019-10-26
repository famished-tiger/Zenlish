# CHANGELOG

## [0.1.12] - 2019-10-26
__Zenlish__ can parse all sentences in lesson 1 and 2-A..2-D from
 [Learn These Words First](http://learnthesewordsfirst.com/).

## [0.1.11] - 2019-10-24
__Zenlish__ can parse all sentences in lesson 1 and 2-A..2-C from
 [Learn These Words First](http://learnthesewordsfirst.com/).

 ### Added
 - Class `ModalVerbCan` to represent the modal verb `can`.
 - Class `RegularVerbWant` to represent the lexical verb `want`.

 ### Changed
 - File `zparser_spec.rb`: tests include all sentences from lesson 2-D (105 sentences in total).
 - `ZenlishGrammar`: generalized one `negative_sentence` production rule.
 - File `minimal_lexicon.rb`: new entries in lexicon `bad`, `feel`, `for`, `good`.
 - File `README.md` Updated the metrics table

## [0.1.10] - 2019-10-23
__Zenlish__ can parse all sentences in lesson 1 and 2-A..2-B from
 [Learn These Words First](http://learnthesewordsfirst.com/).

### Added
- Class `ConjunctivePronoun` to represent the conjunctive `what`.
- Class `IrregularVerbDo` to represent the lexical verb `do`.

### Changed
- File `zparser_spec.rb`: tests include all sentences from lesson 2-B (87 sentences in total).
- `ZenlishGrammar`: added support for complex sentence with one dependent clause like: "Something happens to Lisa because Tony does this.".
- File `minimal_lexicon.rb`: new entries in lexicon `because`, `do`, `happen`,`with`.
- File `README.md` Updated the metrics table

## [0.1.09] - 2019-10-22
__Zenlish__ can parse all sentences in lesson 1 and 2-A from
 [Learn These Words First](http://learnthesewordsfirst.com/).

### Added
- Class `ConjunctivePronoun` to represent the conjunctive `what`.
- Class `IrregularVerbHave` to represent the lexical verb `have`.
- File `.appveyor.yml`

### Changed
- File `zparser_spec.rb`: tests include all sentences from lesson 2-A (77 sentences in total).
- `ZenlishGrammar`: added support for sentence like: "This thing is like two of the other things.".
- File `minimal_lexicon.rb`: new entries in lexicon `have`, `like`, `part`.
- File `README.md` Updated the metrics table, added AppVeyor badge

## [0.1.07] - 2019-10-21
__Zenlish__ can parse all sentences in lessons 1-A ... 1-H from
 [Learn These Words First](http://learnthesewordsfirst.com/).

### Added
- Class `ConjunctivePronoun` to represent the conjunctive `what`.
- Class `IrregularVerbSay` to represent the verb `say`.

### Changed
- File `zparser_spec.rb`: tests include all sentences from lesson 1-H (70 sentences in total).
- `ZenlishGrammar`: added support for quoted text.
- File `minimal_lexicon.rb`: new entries in lexicon `about`, `false`, `hear`,
 `say`, `to`, `true`, `what`, `word`.
- File `README.md` Updated the metrics table.

## [0.1.06] - 2019-10-20
__Zenlish__ can parse all sentences in lessons 1-A ... 1-G from
 [Learn These Words First](http://learnthesewordsfirst.com/).

### Changed
- File `zparser_spec.rb`: tests include all sentences from lesson 1-G (59 sentences in total).
- File `minimal_lexicon.rb`: new entries in lexicon `above`, `in`, `on`,
 `place`, `side`.
- File `README.md` Updated the metrics table.


## [0.1.05] - 2019-10-19
__Zenlish__ can parse all sentences in lessons 1-A ... 1-F from
 [Learn These Words First](http://learnthesewordsfirst.com/).

 ### Added
- Class `Conjunction` to represent conjunctions.
- Class `LinkingAdverb` to represent adverbs like `then`.
- Class `PrepositionOf` to represent the preposition `of`.
- Class `RegularVerb` to represent lexical verbs that have a regular conjugation like `touch`.
- Class `SubordinatingConjunction` to represent subordinating conjunctions like `if`.


### Changed
- File `zparser_spec.rb`: tests include all sentences from lesson 1-F (48 sentences in total).
- `ZenlishGrammar`: rule refactoring and enhancements (i.e. conditional_statement, verb_grouping).
- File `minimal_lexicon.rb`: new entries in lexicon `another`, `be` (as auxiliary verb),
 `far`, `from`, `if`, `kind`, `near to`, `of`, `then`, `touch`.
- File `README.md` Updated the metrics table. Added badges for Travis CI and license.

 ### Fixed
- File `LICENSE.txt` Missing name.

## [0.1.04] - 2019-10-15
__Zenlish__ can parse all sentences in lessons 1-A ... 1-E from
 [Learn These Words First](http://learnthesewordsfirst.com/).

 ### Added
- Class `DegreeAdverb` to represent degree adverb like `very`.
- Class `DemonstrativePronoun` to represent the adverb `there` (for `there is`, `there are`).

### Changed
- File `zparser_spec.rb`: tests include all sentences from lesson 1-E (37 sentences).
- `ZenlishGrammar`: new rules (i.e. negative_sentence, ...).
- File `minimal_lexicon.rb`: new entries in lexicon `alive`, `big`, `living`,
`small`, `this one` and `very`.
- File `README.md` Added a table with a couple of metrics.

## [0.1.03] - 2019-10-13
__Zenlish__ can parse all sentences in lessons 1-A ... 1-D from
 [Learn These Words First](http://learnthesewordsfirst.com/).

 ### Added
- Class `AdverbNot` to represent adverb `not` (for negative sentences).
- Class `AdverbThere` to represent the adverb `there` (for `there is`, `there are`).
- Class `AuxiliaryDo` to represent the auxiliary `do` verb.
- Class `IrregularVerbBe` to represent the verb `be` when used as a lexical verb.
- Class `PrepositionThan` to use with comparative clauses.

### Changed
- File `zparser_spec.rb`: tests include all sentences from lesson 1-D.
- `ZenlishGrammar`: new rules (i.e. negative_sentence, ...).

## [0.1.02] - 2019-10-11
__Zenlish__ can parse all sentences in lessons 1-A, 1-B, 1-C from
 [Learn These Words First](http://learnthesewordsfirst.com/).

 ### Added
 - Class `Adverb` to represent adverb word class.
 - Class `Preposition` to represent the preposition word class.
 - Class `IndefiniteQuantifier` to represent the indefinite quantifier word class (e.g. `many`).
 - File `empty_lexion_factory.rb`: added the `Adverb`, `Preposition` and `IndefiniteQuantifier` as word classes in lexicon.
 - File `minimal_lexicon.rb`: new entries in lexicon `is` (from verb `be`),
 `inside`, `many`, `not`.
  - File `zenlish.gemspec`: now contains `.travis.yml` and `CODE_OF_CONDUCT.md.

 ### Changed
 - File `README.md` minor editorial changes.
 - File `zparser_spec.rb`: tests include all sentences from lesson 1-C.
 - `ZenlishGrammar`: new rules (i.e. adverb_phrase, preposition_phrase).


## [0.1.01] - 2019-10-10
__Zenlish__ can parse all sentences in lessons 1-A, 1-B from [Learn These Words First](http://learnthesewordsfirst.com/).

### Added
- Class `Numeral` to represent the abstract word class for cardinal and ordinal numbers.
- Class `Cardinal` to represent the word class of cardinal numbers.
 - Class `ComparativeArticle` to represent the word class of the `as` in `same as`.
- File `empty_lexion_factory.rb`: added the `Cardinal` and `ComparativeArticle` as word classes in lexicon.
- File `minimal_lexicon.rb`: new entries in lexicon `as` (from same ... as expression),
`one`, `two`, `person` , `people.`


### Changed
- File `README.md` added Rubygems badge.
- File `zparser_spec.rb`: tests include all sentences from lesson 1-B.
- `ZenlishGrammar`: grammar refactoring and extension.


### Fixed
- File `zenlish.gemspec`: fixed typo in a Github hyperlink.

## [0.1.0] - 2019-10-06
Initial project commit in Github and first gem version released.
