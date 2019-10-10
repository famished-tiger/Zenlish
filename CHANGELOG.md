# CHANGELOG

## [0.1.01] - 2019-10-10
__Zenlish__ can parse all the sentences in lessons 1-A, 1-B from [Learn These Words First](http://learnthesewordsfirst.com/).

### Added
- Class `Cardinal` to represent the abstract word class for cardinal and ordinal numbers.
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
