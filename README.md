# Zenlish
[![Gem Version](https://badge.fury.io/rb/zenlish.svg)](https://badge.fury.io/rb/zenlish)

### What is __Zenlish__ ?  

Zenlish = Zen + English  

__Zenlish__ will be a Controlled Natural Language based on English.  
A [Controlled Natural Language](https://en.wikipedia.org/wiki/Controlled_natural_language)
is a subset of a natural language -here English- limited to specific problem domains.

The goal of this project is to implement a toolkit for a subset of the English language.


### Design of Zenlish language
#### Minimalism
The name of the language is a combination of 'Zen' and 'English'.  
It reflects a desire to make Zenlish a simple language:  
- The focus is put on a simplified syntax,
- A limited lexicon. Priority on most commonly used words.


#### Expressiveness
Zenlish should be rich enough to express ideas, facts in a fluid way (vs. contrived, artificial way).
Litmus test: a Zenlish text should be easy to read to a English reading person.

### Zenlish as a library (gem)
Over time, the zenlish gem will contain:
- A tokenizer (tagging, lemmatizer)
- A lexicon [STARTED]
- A context-free grammar [STARTED]
- A parser [STARTED]
- Feature unification (for number, gender agreement)
- A simplified ontology


### What is the purpose of __Zenlish__ ?
With __Zenlish__ it should be possible for a Ruby application to interact with
users with a language that is close enough to English.

### Project status

The project is still in inception. 
#### Some project metrics (v. 0.1.04)
|Metric|Value|  
|:-:|:-:|
| Number of lemmas in lexicon           | 32 |
| Number of production rules in grammar | 53 |
| Number of lessons covered             |  4 |
| Number of sentences in spec files     | 37 |


### Roadmap
 
Here a tentative roadmap:

#### A) Support vocabulary and sentences from [Learn These Words First](http://learnthesewordsfirst.com/)
This website advocates the idea of a multi-layered dictionary.
At the core, there are about 300 essential words.  
The choice of these words is inspired by the semantic primitives of [NSM
(Natural Semantic Metalanguage)](https://en.wikipedia.org/wiki/Natural_semantic_metalanguage).  
The essential words are introduced in twelve lessons. Each lesson put the Words
in examplar sentences and pictures.

The project sub-goals are:
- To inject the 300 core words into Zenlish lexicon,
- Zenlish should be able to parse all the example sentences
- Also Zenlish should determine the semantics (i.e. meaning) of the sentences

#### B) Capability to read a complete book
A good candidate book is "The Edge of the Sky" by Roberto Trotta (ISBN 978-0-465-04471-9 : hardcover, ISBN 978-0-465-04490-0 : ebook).  
Professor Trotta challenged himself by writing a book on Cosmology with the 1000 most used words. More details [here](http://robertotrotta.com/the-edge-of-the-sky/).

In order to achieve this goal, Zenlish should:
- Incorporate the 1000 words in its lexicon
- Have a grammar that allows the parsing of the sentences in the book.

#### C) Capability to interpret the meaning of a complete book
Probably, far-fetched. But it will be nice to launch query to Zenlish to check if
it has some understanding of the text it reads (i.e. has a semantic representation).



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zenlish'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zenlish

## Usage

TODO: Write usage instructions here

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/famished-tiger/Zenlish. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Zenlish project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/famished-tiger/Zenlish/blob/master/CODE_OF_CONDUCT.md).
