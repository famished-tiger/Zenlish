# CHANGELOG

## [0.1.02] - 2019-10-11
__Zenlish__ can parse all the sentences in lessons 1-A, 1-B, 1-C from
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
__Zenlish__ can parse all the sentences in lessons 1-A, 1-B from [Learn These Words First](http://learnthesewordsfirst.com/).

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
