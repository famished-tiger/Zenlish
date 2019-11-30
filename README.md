# Zenlish
[![Linux build Status](https://travis-ci.org/famished-tiger/Zenlish.svg?branch=master)](https://travis-ci.org/famished-tiger/Zenlish)
[![Build status](https://ci.appveyor.com/api/projects/status/bef59whiacuv51yn?svg=true)](https://ci.appveyor.com/project/famished-tiger/zenlish)
[![Gem Version](https://badge.fury.io/rb/zenlish.svg)](https://badge.fury.io/rb/zenlish)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg?style=flat)](https://github.com/famished-tiger/Zenlish/blob/master/LICENSE.txt)
### What is __Zenlish__ ?  

Zenlish = Zen + English  

__Zenlish__ will be a Controlled Natural Language based on English.  
A [Controlled Natural Language](https://en.wikipedia.org/wiki/Controlled_natural_language)
is a subset of a natural language -here English- limited to specific problem domains.


### What is the purpose of __Zenlish__ ?
The goal of this project is to implement a toolkit for a subset of the English language.
With __Zenlish__ it should be possible for a Ruby application to interact with
users with a language that is close enough to English.

### Project status

The project is still in inception. Currently, zenlish is able to parse all
sentences from lessons 1-A up to 3-C. The parser is able to cope with syntactical
ambiguities generating parse forests instead of parse trees.

The intent is to deliver gem versions in small increments.

#### Zenlish as a library (gem)
Over time, the zenlish gem will contain:
- A tokenizer (tagging, lemmatizer)[TODO]
- A lexicon [STARTED]
- A context-free grammar [STARTED]
- A parser [STARTED]
- Feature unification (for number, gender agreement)[TODO]
- A simplified ontology[TODO]


#### Some project metrics (v. 0.1.15)
|Metric|Value|  
|:-:|:-:|
| Number of lemmas in dictionary        | 115  |
| [Coverage 100 commonest English words](https://en.wikipedia.org/wiki/Most_common_words_in_English)  | 57% |
| Number of production rules in grammar | 160 |
| Number of lessons covered             | 19  |
| Number of sentences in spec files     | 273 |


## Installation...
### ...with Rubygem
Install the gem yourself as:

    $ gem install zenlish

### ...with Bundler
Add this line to your application's Gemfile:

```ruby
gem 'zenlish'
```

And then execute:

    $ bundle


### Some code snippets

#### Interacting with the dictionary:
```ruby
require 'zenlish'

# Retrieving a "word" (more precisely, a lexeme) from the dictionary.
lexeme = Zenlish::Lang::Dictionary.get_lexeme('move')

# What is the Ruby class of a lexeme?
p lexeme.class # => Zenlish::Lex::Lexeme

# What is the word class of verb 'move'?
p lexeme.wclass.class # => Zenlish::WClasses::RegularVerb

# Here is some Zenlish text to analyze:
some_text = 'one person can move to the same place.'
p some_text

some_text.scan(/(?:\w+)|[\.,:"]/).each do |entry|
  lexeme = Zenlish::Lang::Dictionary.get_lexeme(entry)
  p lexeme.wclass.class
end

# Loop result should be:
# Zenlish::WClasses::Cardinal
# Zenlish::WClasses::CommonNoun
# Zenlish::WClasses::ModalVerbCan
# Zenlish::WClasses::RegularVerb
# Zenlish::WClasses::Preposition
# Zenlish::WClasses::DefiniteArticle
# Zenlish::WClasses::Adjective
# Zenlish::WClasses::CommonNoun
# Rley::Syntax::Terminal
```

More to come...

## Principles behind the Zenlish language


#### Minimalism
The name of the language is a combination of 'Zen' and 'English'.  
It reflects a desire to make Zenlish a simple language:  
- The focus is put on a simplified syntax,
- A limited lexicon. Priority on most commonly used words.


#### Expressiveness
Zenlish should be rich enough to express ideas, facts in a fluid way (vs. contrived, artificial way).
Litmus test: a Zenlish text should be easy to read to a English reading person.


## Roadmap

Here a tentative roadmap:

#### A) Ability to parse sentences from [Learn These Words First](http://learnthesewordsfirst.com/)
*STARTED*. 19.8% complete  
This website advocates the idea of a multi-layered dictionary.
At the core, there are about 300 essential words.  
The choice of these words is inspired by the semantic primitives of [NSM
(Natural Semantic Metalanguage)](https://en.wikipedia.org/wiki/Natural_semantic_metalanguage).  
The essential words are introduced in twelve lessons. Each lesson put the words
in exemplar sentences and pictures.

The milestone sub-goals are:
- To inject the 300 core words into Zenlish lexicon,
- Zenlish should be able to parse all the example sentences

#### B) Associate lexical features to terms in lexicon
The sub-goals are:
- To enrich the lexicon entries with lexical and syntactical features.
- Zenlish should be able to derive the declensions of nouns, conjugation of verbs,
- Also Zenlish should detect agreement errors
- Ideally, Zenlish should have a lemmatizer

#### C) Enrich lexicon entries with semantical features and relationships
The sub-goals are:
- To enrich the lexicon entries with lexical and syntactical features.
- Zenlish should be able to derive the declensions of nouns, conjugation of verbs,
- Also Zenlish should detect agreement errors

#### D) Build a generic ontology and map Zenlish text to it.
The sub-goals are:
- To have a simplified ontology that covers the concepts covered in the lesson sentences.
- Hopefully Zenlish should be answer to queries related to the lesson sentences.

#### E) Capability to parse a complete book
A good candidate book is "The Edge of the Sky" by Roberto Trotta (ISBN 978-0-465-04471-9 : hardcover, ISBN 978-0-465-04490-0 : ebook).  
Professor Trotta challenged himself by writing a book on Cosmology with the 1000 most used words. More details [here](http://robertotrotta.com/the-edge-of-the-sky/).

In order to achieve this goal, Zenlish should:
- Incorporate the 1000 words in its lexicon
- Have a grammar that allows the parsing of the sentences in the book.

#### F) Capability to interpret the meaning of a complete book
Probably, far-fetched. But it will be nice to launch query to Zenlish to check if
it has some understanding of the text it reads (i.e. has a semantic representation).



## Usage

TODO: Write usage instructions here

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/famished-tiger/Zenlish. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Zenlish project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/famished-tiger/Zenlish/blob/master/CODE_OF_CONDUCT.md).
