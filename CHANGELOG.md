# CHANGELOG
## [0.2.07] - 2025-04-03
Minor changes

### Changed
- File `zenlish.gempsec` updated versions in depedencies
- Code re-styling to please `Rubocop` 1.75.1
- Spec files re-styling to please `rubocop-rspec` 3.5.0

## [0.2.06] - 2021-09-04
- Fixes and code re-styling to please `Rubocop` 1.19.1

### Changed
- File `zenlish.gemspec` updated dependency towards `rley` gem (now ~> 0.8.03)

### Fixed
- File `zenlish_grammar.rb` fixed small code breaking caused due to `Rley` v.0.8+ library.
- File `lexer_spec.rb` corrected a test.

# CHANGELOG
## [0.2.05] - 2020-02-16
Zenlish can now inflect all the lexemes in its lexicon.

### Changed
- File `README.md` added demo example showing the inflection capabilities of Zenlish
- Method `Lex::Lexeme#all_inflections` added.
- Method `Inflect::InflectionTable#all_inflections` added.
- Class `WClass::DemonstrativeDeterminer`: added specific inflection tables.
- Class `WClass::PersonalPronoun`: added specific inflection tables.
- Class `WClass::PossessiveDeterminer`: added specific inflection tables.
- Method `Feature::BooleanDomain#to_a` added.
- Method `Feature::EnumerationDomain#to_a` added.
- Method `WClasses::WordClass#add_paradigm` added.

### Fixed
- Inflection table of `WClasses::IrregularVerb`
- Inflection table of `WClasses::RegularVerb`

### Removed
- Method `WClasses::Verb#add_paradigm` removed.

## [0.2.04] - 2020-02-09
Zenlish can now inflect all the verbs in its lexicon.

### Added
- Module `WordClasses::IrregularVerbCan` for cases where `can` isn't used as a modal verb.

## Changed
- File `dictionary.rb`: .
- Class `Lex::Lexicon`: more explicit error message in case of ambiguous lexeme search.
- Class `WClass::AuxiliaryBe`: added specific inflection table.
- Class `WClass::AuxiliaryDo`: added specific inflection table.
- Class `WClass::ModalVerbCan`: added specific inflection table.

### Fixed
- Class `WordClass::IrregularVerb` fixed rule for gerund spelling for verbs ending with 'oe' or 'ye'.
- Class `WordClass::RegularVerb` fixed rule for gerund spelling for verbs ending with 'oe' or 'ye'.

# CHANGELOG
## [0.2.03] - 2020-02-07
Zenlish can now inflect the irregular verbs `be`, `do`, and `have`.

## Changed
- Class `WClass::IrregularVerbBe`: added specific inflection table.
- Class `WClass::IrregularVerbDo`: added specific inflection table.
- Class `WClass::IrregularVerbHave`: added specific inflection table.

## [0.2.02] - 2020-02-06
Extending the inflection model to irregular verbs. Zenlish can inflect all irregular verbs in its dictionary (except modals and be).

### Added
- Module `WordClasses::IreegularVerbExtension` mix-in module for extending the lexeme for irregular verbs.

### Changed
- File `dictionary.rb`: added past simple and past participles to most irregular verbs in lexicon.
- Class `Lex::Lexeme`: added capability of word class to add dynamically extension (specialization) to lexeme instances.
- Class `WordClass::IrregularVerb` added inflection table.
- File `.travis.yml` Added Ruby 2.7 and increased version number for other rubies.

### Fixed
- Class `WordClass::RegularVerb` fixed rules for gerund spelling.

## [0.2.01] - 2020-02-02
Extending the inflection table capabilities.
Extending the inflection model to regular verbs. Zenlish can inflect all regular verbs in its dictionary.

### Added
- Class `Inflect::FunctionCall` Now an inflection table can invoke a method of the lexeme argument.
- Class `Inflect::Membership` Now an inflection table can test whether a value is included in a set of values.
- Class `Inflect::NotEquals` Now an inflection table can test for inequality

## [0.2.00] - 2020-01-30
A lot of internal additions, such an initial feature model, embryonic inflection model.
This is WIP.

### Added
- New subfolder `feature` that hosts classes for implementing features (= properties that can be attached to words)
- New subfolder `inflect` that hosts classes for implmenting inflection tables (kind of decision tables)
### Changed
- File `dictionary.rb`: new entries in lexicon `damage`, `difficult`
- File `dictionary.rb`: common nouns with special inflection rules (e.g. pluralized form) have their paradigm specified
- Class `Lexeme` can have its own set of feature definitions.
- Class `WordClass` ca have its own set of feature definitions.
- Class `Noun` has the feature definitions for: `NUMBER`, `COUNTABILITY` and `PARADIGM`

## [0.1.25] - 2019-12-06
__Zenlish__ can parse all sentences in lesson 1, 2 and 3-A .. 3-G (352 sentences in total) from
 [Learn These Words First](http://learnthesewordsfirst.com/).

### Changed
 - File `lesson3_spec.rb`: tests include all sentences from lesson 3-A to 3-G.
 - `ZenlishGrammar`: refactoring of the predicative_sentence rules.
 - File `dictionary.rb`: new entries in lexicon `between`, `choose`, `machine`.
 - File `README.md` Updated the metrics table

## [0.1.24] - 2019-12-05
__Zenlish__ can parse all sentences in lesson 1, 2 and 3-A .. 3-F (323 sentences in total) from
 [Learn These Words First](http://learnthesewordsfirst.com/).

### Added
 - Class `ModalVerbCould` to represent the auxiliary verb `could`.
 - Support module `Var2Word`: used to create variable names and assign them specific `Literal` objects.

 ### Changed
 - File `zparser_spec.rb` splitted. Lesson-specific test suites have their own spec file.
 - File `lesson3_spec.rb`: tests include all sentences from lesson 3-A .. 3-F.
 - `ZenlishGrammar`: more rules for relative clauses.
 - File `dictionary.rb`: new entries in lexicon `change`, `could`, `surface`, `try`.
 - File `README.md` Updated the metrics table

## [0.1.23] - 2019-12-04
__Zenlish__ can parse all sentences in lesson 1, 2 and 3-A .. 3-E from
 [Learn These Words First](http://learnthesewordsfirst.com/).

 ### Changed
 - File `zparser_spec.rb`: tests include all sentences from lesson 1, 2, and 3-F (308 sentences in total).
 - `ZenlishGrammar`: more rules for negative sentences.
 - File `dictionary.rb`: new entries in lexicon `contain`, `container`, `make`.
 - File `README.md` Updated the metrics table

## [0.1.22] - 2019-12-03
__Zenlish__ can parse all sentences in lesson 1, 2 and 3-A .. 3-D from
 [Learn These Words First](http://learnthesewordsfirst.com/).

 ### Changed
 - File `zparser_spec.rb`: tests include all sentences from lesson 1, 2, and 3-D (290 sentences in total).
 - `ZenlishGrammar`: allow coordination of determiners.
 - File `dictionary.rb`: new entries in lexicon `become`, `exist`, `someplace`.
 - File `README.md` Updated the metrics table

## [0.1.21] - 2019-12-02
__Zenlish__ can parse all sentences in lesson 1, 2 and 3-A .. 3-C from
 [Learn These Words First](http://learnthesewordsfirst.com/).

 ### Added
 - Class `DistributiveDeterminer` to represent the words `each`, `every`, `either`, `neither`.
 - Class `FrontingQuantifier` to represent the quantifiers `all` and `both`.

 ### Changed
 - File `zparser_spec.rb`: tests include all sentences from lesson 1, 2, and 3-D (277 sentences in total).
 - `ZenlishGrammar`: rewrite of rules for determiner syntax.
 - Class `IndefiniteQuantifier` renamed to `Quantifier`
 - File `dictionary.rb`: new entries in lexicon `each`, `use`.
 - File `README.md` Updated the metrics table

## [0.1.20] - 2019-11-30
__Zenlish__ can parse all sentences in lesson 1, 2 and 3-A .. 3-C from
 [Learn These Words First](http://learnthesewordsfirst.com/).

 ### Added
 - Class `PossessiveDeterminer` to represent the posessive determiners `its`, `my`, `their`, `your`.

 ### Changed
 - File `zparser_spec.rb`: tests include all sentences from lesson 1, 2, and 3-C (255 sentences in total).
 - `ZenlishGrammar`: new production rules added (especially for posessive determiners a multiple sentences in direct speech).
 - File `dictionary.rb`: new entries in lexicon `animal`, `but`, `cause`.
 - File `README.md` Updated the metrics table

## [0.1.19] - 2019-11-28
__Zenlish__ can parse all sentences in lesson 1, 2 and 3-A .. 3-B from
 [Learn These Words First](http://learnthesewordsfirst.com/).

 ### Added
 - Class `PossessiveDeterminer` to represent the posessive determiners `its`, `my`, `their`, `your`.

 ### Changed
 - File `zenlish.gemspec`: raise an error if Rley version is < 0.7.06
 - File `zparser_spec.rb`: tests include all sentences from lesson 1, 2, and 3-B (255 sentences in total).
 - `ZenlishGrammar`: new production rules added (especially for posessive determiners a multiple sentences in direct speech).
 - File `dictionary.rb`: new entries in lexicon `and`, `belong`, `it`, `or`, `that`, `them`, `they`.
 - File `README.md` Updated the metrics table

## [0.1.18] - 2019-11-26
__Zenlish__ can parse all sentences in lesson 1, 2 and 3-A from
 [Learn These Words First](http://learnthesewordsfirst.com/).

 ### Added
 - Class `Coordinator` to represent the coordinating conjunctions `and`, `or`.

 ### Changed
 - File `zparser_spec.rb`: tests include all sentences from lesson 1, 2, and 3-A (235 sentences in total).
 - `ZenlishGrammar`: new production rules added (especially for coordinators).
 - File `dictionary.rb`: new entries in lexicon `and`, `belong`, `it`, `or`, `that`, `them`, `they`.
 - File `README.md` Updated the metrics table

## [0.1.17] - 2019-11-25
__Zenlish__ can parse all sentences in lesson 1 and 2-A..2-H from
 [Learn These Words First](http://learnthesewordsfirst.com/).

 ### Added
 - Class `AdverbMaybe` to represent the relative pronoun `who`.

 ### Changed
 - Folder structure under `lib` and `spec`.
 - File `zparser_spec.rb`: tests include all sentences from lesson 2-H (207 sentences in total).
 - `ZenlishGrammar`: new production rules added (especially for linking/copular verbs).
 - File `dictionary.rb`: new entries in lexicon `below`, `live`, `maybe`.
 - File `README.md` Updated the metrics table

## [0.1.16] - 2019-11-23
__Zenlish__ can parse all sentences in lesson 1 and 2-A..2-G from
 [Learn These Words First](http://learnthesewordsfirst.com/).

### Changed
- `ZenlishGrammar`: Vast grammar reworking.
- File `dictionary.rb`: `there` in lexicon has `ExistentialThere` as word class.
- File `dictionary.rb`: new entries for `body`, `one` (as indefinite pronoun), `two` (as indefinite pronoun)
- Class `ZParser`: Added method `to_pforest` to generate a parse forest, `to_ptree` is an alias of `parse`

## [0.1.15] - 2019-11-02
__Zenlish__ can parse all sentences in lesson 1 and 2-A..2-G from
 [Learn These Words First](http://learnthesewordsfirst.com/).

 ### Added
 - Class `RelativePronoun` to represent the relative pronoun `who`.

 ### Changed
 - Folder structure under `lib` and `spec`.
 - File `zparser_spec.rb`: tests include all sentences from lesson 2-E (136 sentences in total).
 - `ZenlishGrammar`: new production rules added.
 - File `dictionary.rb`: new entries in lexicon `moment`, `much`, `someone`, `when`, `who`.
 - File `README.md` Updated the metrics table

## [0.1.14] - 2019-11-01
__Zenlish__ can parse all sentences in lesson 1 and 2-A..2-F from
 [Learn These Words First](http://learnthesewordsfirst.com/).

 ### Added
 - Class `IrregularVerbKnow` to represent the verb `know`.
 - Class `IrregularVerbThink` to represent the verb `think`.
 - Class `PersonalPronoun` to represent the pronouns `I`, `you`.

 ### Changed
 - Folder structure under `lib` and `spec`.
 - File `zparser_spec.rb`: tests include all sentences from lesson 2-E (184 sentences in total).
 - `ZenlishGrammar`: new production rules for multiple sentence parsing, personal pronouns and dependent clauses without conjunctions.
 - File `dictionary.rb`: new entries in lexicon `I`, `me`, `you`, `here`, `now`.
 - File `README.md` Reshuffled sections, added one code snippet, updated the metrics table

## [0.1.13] - 2019-10-28
__Zenlish__ can parse all sentences in lesson 1 and 2-A..2-E from
 [Learn These Words First](http://learnthesewordsfirst.com/).

 ### Added
 - Class `IndefiniteArticle` to represent the article `a (an)`.

 ### Changed
 - File `zparser_spec.rb`: tests include all sentences from lesson 2-E (118 sentences in total).
 - `ZenlishGrammar`: added production rules for adverbial and prepositional phrases put in front position.
 - File `minimal_lexicon.rb`: new entries in lexicon `a`, `at`, `before`, `long`,
`short`, `move`
 - File `README.md` Updated the metrics table

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
