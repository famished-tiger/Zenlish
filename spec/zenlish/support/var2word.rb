require_relative 'minimal_lexicon'
require_relative '../../../lib/zenlish/lex/literal'

module Zenlish
  # Utility module. It defines variables that each are assgned a
  # Literal object.
  module Var2Word
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
    literal2var('a', 'an')
    literal2var('about', 'about')
    literal2var('above', 'above')
    def after_adverb ; Lex::Literal.new('after', get_lexeme('after', WClasses::Adverb), 0) ; end
    def after_as_prep ; Lex::Literal.new('after', get_lexeme('after', WClasses::Preposition), 0) ; end
    def after_ ; Lex::Literal.new('after', get_lexeme('after', WClasses::SubordinatingConjunction), 0) ; end
    literal2var('alive', 'alive')
    literal2var('all', 'all')
    def am ; Lex::Literal.new('am', get_lexeme('be', WClasses::IrregularVerbBe), 0) ; end
    literal2var('and', 'and', '_')
    literal2var('animal', 'animal')
    literal2var('animal', 'animals')
    def another ; Lex::Literal.new('another', get_lexeme('another', WClasses::Adjective), 0) ; end
    def another_as_pronoun ; Lex::Literal.new('another', get_lexeme('another', WClasses::Pronoun), 0) ; end
    def are ; Lex::Literal.new('are', get_lexeme('be', WClasses::IrregularVerbBe), 0) ; end
    literal2var('as', 'as')
    literal2var('at', 'at')
    literal2var('bad', 'bad')
    def be_ ; Lex::Literal.new('be', get_lexeme('be', WClasses::IrregularVerbBe), 0) ; end
    literal2var('because', 'because')
    literal2var('become', 'became')
    literal2var('become', 'become')
    literal2var('become', 'becomes')
    def before_adverb ; Lex::Literal.new('before', get_lexeme('before', WClasses::Adverb), 0) ; end
    def before_as_adj ; Lex::Literal.new('before', get_lexeme('before', WClasses::Adjective), 0) ; end
    def before_as_prep ; Lex::Literal.new('before', get_lexeme('before', WClasses::Preposition), 0) ; end
    def before ; Lex::Literal.new('before', get_lexeme('before', WClasses::SubordinatingConjunction), 0) ; end
    literal2var('belong', 'belong')
    literal2var('belong', 'belongs')
    literal2var('below', 'below')
    literal2var('between', 'between')
    literal2var('big', 'big')
    literal2var('big', 'bigger')
    literal2var('body', 'body')
    literal2var('but', 'but')
    literal2var('can', 'can')
    literal2var('cause', 'cause')
    literal2var('cause', 'caused')
    literal2var('cause', 'causes')
    literal2var('change', 'change', '_')
    literal2var('change', 'changed')
    literal2var('change', 'changes')
    literal2var('choose', 'choose')
    literal2var('choose', 'chose')
    literal2var('contain', 'contain')
    literal2var('contain', 'contains')
    literal2var('container', 'container')
    literal2var('container', 'containers')
    literal2var('could', 'could')
    def did ; Lex::Literal.new('did', get_lexeme('do', WClasses::IrregularVerbDo), 0) ; end
    literal2var('die', 'die')
    literal2var('die', 'died')
    literal2var('die', 'dies')
    literal2var('different', 'different')
    def do_ ; Lex::Literal.new('do', get_lexeme('do', WClasses::IrregularVerbDo), 0) ; end
    def do_aux ; Lex::Literal.new('do', get_lexeme('do', WClasses::AuxiliaryDo), 0) ; end
    def does ; Lex::Literal.new('does', get_lexeme('do', WClasses::IrregularVerbDo), 0) ; end
    def does_aux ; Lex::Literal.new('does', get_lexeme('do', WClasses::AuxiliaryDo), 0) ; end
    literal2var('each', 'each', '_')
    def each_ ; Lex::Literal.new('each', get_lexeme('each', WClasses::DistributiveDeterminer), 0) ; end
    def each_as_pronoun ; Lex::Literal.new('each', get_lexeme('each', WClasses::Pronoun), 0) ; end
    literal2var('exist', 'exist')
    literal2var('exist', 'existed')
    literal2var('exist', 'exists')
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
    literal2var('hear', 'hear')
    literal2var('hear', 'heard')
    literal2var('hear', 'hears')
    def here ;     Lex::Literal.new('here', get_lexeme('here', WClasses::Adverb), 0) ; end
    def here_as_noun ;  Lex::Literal.new('here', get_lexeme('here', WClasses::CommonNoun), 0) ; end
    def i_pronoun ; Lex::Literal.new('I', get_lexeme('I'), 0) ; end
    literal2var('if', 'if', '_')
    literal2var('in', 'in', '_')
    literal2var('inside', 'inside')
    literal2var('it', 'it', '_')
    literal2var('its', 'its')
    literal2var('J', 'j', '_')
    def is ;     Lex::Literal.new('is', get_lexeme('be', WClasses::IrregularVerbBe), 0) ; end
    def is_aux ; Lex::Literal.new('is', get_lexeme('be', WClasses::AuxiliaryBe), 0) ; end
    literal2var('K', 'k', '_')
    literal2var('kind', 'kind')
    literal2var('kind', 'kinds')
    literal2var('know', 'knew')
    literal2var('know', 'know')
    literal2var('know', 'knows')
    literal2var('like', 'like')
    literal2var('Lisa', 'Lisa')
    literal2var('live', 'lived')
    literal2var('living', 'living')
    literal2var('long', 'long')
    literal2var('machine', 'machine')
    literal2var('machine', 'machines')
    literal2var('make', 'made')
    literal2var('make', 'make')
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
    literal2var('my', 'my')
    literal2var('near', 'near')
    literal2var('near to', 'near_to')
    literal2var('not', 'not', '_')
    def now ; Lex::Literal.new('now', get_lexeme('now', WClasses::Adverb), 0) ; end
    def now_as_noun ; Lex::Literal.new('now', get_lexeme('now', WClasses::CommonNoun), 0) ; end
    literal2var('of', 'of')
    literal2var('on', 'on')
    def one ; Lex::Literal.new('one', get_lexeme('one', WClasses::Cardinal), 0) ; end
    def one_as_adj ; Lex::Literal.new('one', get_lexeme('one', WClasses::Adjective), 0) ; end
    def one_as_pronoun ; Lex::Literal.new('one', get_lexeme('one', WClasses::IndefinitePronoun), 0) ; end
    literal2var('or', 'or', '_')
    literal2var('other', 'other')
    literal2var('part', 'part')
    literal2var('part', 'parts')
    literal2var('people', 'people')
    literal2var('person', 'person')
    literal2var('place', 'place')
    def same ; Lex::Literal.new('same', get_lexeme('same', WClasses::Adjective), 0) ; end
    def same_as_pronoun ; Lex::Literal.new('same', get_lexeme('same', WClasses::Pronoun), 0) ; end
    literal2var('see', 'saw')
    literal2var('short', 'short')
    literal2var('side', 'side')
    literal2var('small', 'small')
    literal2var('small', 'smaller')
    literal2var('some', 'some')
    literal2var('say', 'say')
    literal2var('say', 'said')
    literal2var('say', 'says')
    literal2var('see', 'see')
    literal2var('see', 'sees')
    literal2var('someone', 'someone')
    literal2var('someplace', 'someplace')
    literal2var('something', 'something')
    literal2var('surface', 'surface')
    literal2var('the', 'the')
    literal2var('their', 'their')
    literal2var('them', 'them')
    literal2var('then', 'then', '_')
    literal2var('they', 'they')
    literal2var('than', 'than')
    literal2var('that', 'that')
    literal2var('there', 'there')
    literal2var('thing', 'thing')
    literal2var('thing', 'things')
    literal2var('think', 'think')
    literal2var('think', 'thinking')
    literal2var('think', 'thinks')
    literal2var('think', 'thought')
    def these ; Lex::Literal.new('these', get_lexeme('this', WClasses::DemonstrativeDeterminer), 0) ; end
    def these_as_pronoun ; Lex::Literal.new('these', get_lexeme('this', WClasses::DemonstrativePronoun), 0) ; end
    def this ; Lex::Literal.new('this', get_lexeme('this', WClasses::DemonstrativeDeterminer), 0) ; end
    def this_as_pronoun ; Lex::Literal.new('this', get_lexeme('this', WClasses::DemonstrativePronoun), 0) ; end
    literal2var('this one', 'this_one')
    literal2var('time', 'time')
    literal2var('to', 'to')
    literal2var('Tony', 'Tony')
    literal2var('touch', 'touch')
    literal2var('touch', 'touched')
    literal2var('touch', 'touching')
    literal2var('try', 'tried')
    literal2var('true', 'true', '_')
    literal2var('try', 'tries')
    literal2var('try', 'try', '_')
    def two ; Lex::Literal.new('two', get_lexeme('two', WClasses::Cardinal), 0) ; end
    def two_as_pronoun ; Lex::Literal.new('two', get_lexeme('two', WClasses::IndefinitePronoun), 0) ; end
    literal2var('use', 'use')
    literal2var('use', 'used')
    literal2var('use', 'using')
    literal2var('very', 'very')
    literal2var('want', 'want')
    literal2var('want', 'wants')
    def was ; Lex::Literal.new('was', get_lexeme('be', WClasses::IrregularVerbBe), 0) ; end
    def were ;     Lex::Literal.new('were', get_lexeme('be', WClasses::IrregularVerbBe), 0) ; end
    literal2var('what', 'what')
    literal2var('when', 'when', '_')
    def where ; Lex::Literal.new('where', get_lexeme('where', WClasses::Adverb), 0) ; end
    def where_conjunction ; Lex::Literal.new('where', get_lexeme('where', WClasses::SubordinatingConjunction), 0) ; end
    literal2var('who', 'who')
    literal2var('with', 'with')
    literal2var('word', 'words')
    def x_as_noun ; Lex::Literal.new('X', get_lexeme('X'), 0) ; end
    literal2var('you', 'you')
    literal2var('you', 'your')

    def colon ;  Lex::Literal.new(':', get_lexeme(':'), 0) ; end
    def comma ;  Lex::Literal.new(',', get_lexeme(','), 0) ; end
    def dot ;  Lex::Literal.new('.', get_lexeme('.'), 0) ; end
    def quote ;  Lex::Literal.new('"', get_lexeme('"'), 0) ; end
  end # module
end # module