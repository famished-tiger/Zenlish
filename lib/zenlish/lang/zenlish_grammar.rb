# Grammar for a simple subset of English language
# It is called Zenlish

require 'rley' # Load the Rley parsing library
require_relative 'dictionary'

# Carnie 2012
# CP ➝ (C) TP
# TP ➝ {NP/CP} (T) VP
# VP ➝(AdvP+) V (NP)({NP/CP}) (AdvP+) (PP+) (AdvP+)
# NP ➝ (D) (AdjP+) N (PP+) (CP)
# PP ➝ P (NP)
# AdjP ➝ (AdvP) Adj
# AdvP ➝ (AdvP) Adv

# Slide show on ajective and adverb phrases
# https://www.slideshare.net/UtTramTran/advadj-phrase

# A Lexicalized Tree Adjoining Grammar for English
# https://www.cis.upenn.edu/~xtag/tech-report/tech-report.html


########################################
# Define a grammar for a highly English-like language
builder = Rley::Syntax::GrammarBuilder.new do
  add_terminals(*Zenlish::Lang::Dictionary.terminals)

  rule 'zenlish' => 'prose'
  rule 'prose' => 'sentence'
  rule 'prose' => 'prose sentence'

  rule 'sentence' => 'simple_sentence Period'
  rule 'sentence' => 'complex_sentence Period'

  #################
  # Simple sentence
  #################
  rule 'simple_sentence' => 'declarative_simple_sentence'
  rule 'simple_sentence' => 'AdverbMaybe declarative_simple_sentence'
  rule 'declarative_simple_sentence' => 'affirmative_sentence'
  rule 'declarative_simple_sentence' => 'existential_sentence'
  rule 'declarative_simple_sentence' => 'predicative_sentence'
  rule 'declarative_simple_sentence' => 'negative_sentence'
  rule 'declarative_simple_sentence' => 'inexistential_sentence'
  rule 'affirmative_sentence' => 'tense_phrase'
  rule 'affirmative_sentence' => 'prepositional_phrase Comma simple_sentence'
  # Case of time adjunct adverbial put in front position
  rule 'affirmative_sentence' => 'noun_phrase Adverb Comma simple_sentence'

  # there + (auxiliary/raising verb) + be + notional subject.
  rule 'existential_sentence' => 'ExistentialThere IrregularVerbBe existential_subject'
  rule 'negative_sentence' => 'negative_tense_phrase'
  rule 'negative_sentence' => 'negated_predicate_sentence'
  rule 'inexistential_sentence' => 'ExistentialThere IrregularVerbBe AdverbNot existential_subject'
  rule 'existential_subject' => 'noun_phrase adverb_phrase_opt'
  rule 'existential_subject' => 'prepositional_phrase'

  rule 'predicative_sentence' => 'noun_phrase IrregularVerbBe predicative_complement'
  rule 'predicative_sentence' => 'conjunctive_prefix IrregularVerbBe predicative_complement'
  rule 'negated_predicate_sentence' => 'noun_phrase adverb_phrase_opt IrregularVerbBe AdverbNot predicative_complement'
  rule 'negated_predicate_sentence' => 'conjunctive_prefix IrregularVerbBe AdverbNot predicative_complement'
  rule 'predicative_complement' => 'noun_phrase'
  rule 'predicative_complement' => 'adjective_phrase comparative_clause_opt'
  # 3-02d J is one that does this.
  rule 'predicative_complement' => 'adjective_phrase relative_clause_opt'
  # 2-28b X is alive before this moment.
  rule 'predicative_complement' => 'adjective_phrase adverb_phrase noun_phrase'
  # X is far from the start.
  rule 'predicative_complement' => 'adverb_phrase_opt prepositional_phrase'

  #################
  # Complex sentence
  #################
  # Case of dropped ´that´ conjunction
  rule 'complex_sentence' => 'main_clause comma_opt subordinated_clause'
  rule 'complex_sentence' => 'main_clause comma_opt relative_clause'
  rule 'complex_sentence' => 'main_clause comma_opt coordinate_clause'
  rule 'complex_sentence' => 'subordinated_clause Comma main_clause'
  # 3-03b If J is not true, then K is true.
  rule 'complex_sentence' => 'subordinated_clause Comma LinkingAdverb main_clause'
  # CGE 287d: verb + direct object + infinitive clause (without to)
  rule 'complex_sentence' => 'main_clause infinitive_clause'
  # Colon used to introduce an explanatory sentence.
  rule 'complex_sentence' => 'main_clause Colon simple_sentence'
  rule 'comma_opt' => 'Comma'
  rule 'comma_opt' => []

  ######################
  # CLAUSES
  ######################
  rule 'main_clause' => 'simple_sentence'
  rule 'subordinated_clause' => 'subordination_marker dependent_clause'
  rule 'subordination_marker' => 'SubordinatingConjunction'
  rule 'subordination_marker' => 'SubordinatingConjunction PrepositionOf'
  rule 'dependent_clause' => 'simple_sentence'
  rule 'dependent_clause' => 'noun_phrase'
  rule 'infinitive_clause' => 'verb_phrase' # Too broad
  rule 'comparative_clause_opt' => 'comparative_clause'
  rule 'comparative_clause_opt' => []
  rule 'comparative_clause' => 'comparative_start noun_phrase'
  rule 'comparative_clause' => 'comparative_start declarative_simple_sentence'
  # rule 'comparative_clause' => 'comparative_start DefiniteArticle Adjective Cardinal'
  rule 'comparative_start' => 'PrepositionThan'
  rule 'comparative_start' => 'ComparativeParticle'
  rule 'conjunctive_prefix' => 'ConjunctivePronoun noun_phrase verb_phrase'
  rule 'identifying_clause' => 'RelativePronoun verb_phrase'
  rule 'relative_clause_opt' =>  'relative_clause'
  rule 'relative_clause_opt' => []
  rule 'relative_clause' => 'RelativePronoun tense_phrase'
  # Sentence 3-Bxa 'Lisa sees a living thing that is very big.
  rule 'relative_clause' => 'RelativePronoun IrregularVerbBe predicative_complement'
  rule 'relative_clause' => 'identifying_clause'
  rule 'coordinate_clause' => 'Coordinator simple_sentence'
  # Implicit subject. 3-05b: I saw this thing and touched some of its parts.
  rule 'coordinate_clause' => 'Coordinator verb_phrase'


  ##############
  # TENSE PHRASE
  ##############
  rule 'tense_phrase' => 'noun_phrase tense_opt verb_phrase'
  rule 'negative_tense_phrase' => 'noun_phrase tense AdverbNot verb_phrase'
  rule 'tense_opt' => 'tense'
  rule 'tense_opt' => []
  rule 'tense' => 'AuxiliaryBe'
  rule 'tense' => 'AuxiliaryDo'
  rule 'tense' => 'ModalVerbCan'

  #############
  # NOUN PHRASE
  #############
  rule 'noun_phrase_opt' => 'noun_phrase'
  rule 'noun_phrase_opt' => []
  rule 'noun_phrase' => 'pre_head_np head_np post_head_np'
  rule 'noun_phrase' => 'noun_phrase Coordinator noun_phrase'
    # someone, somebody, something, somewhere; no one, nobody, nothing,
    # nowhere; anyone, anybody, anything, anywhere; everyone, everybody,
    # everything, everywhere, the attributive adjective phrase occurs as a postmodifier
  rule 'pre_head_np' => 'determiners adjective_phrase_opt'
  rule 'head_np' => 'CommonNoun'
  rule 'head_np' => 'ProperNoun'
  rule 'head_np' => 'PersonalPronoun'
  rule 'head_np' => 'DemonstrativePronoun'
  rule 'head_np' => 'IndefinitePronoun'
  # rule 'head_np' => 'Cardinal' # ... as indefinite pronoun in complement "There were three pies. I ate one."
  rule 'post_head_np' => 'adjective_phrase_opt prepositional_phrases clause_noun_opt'
  rule 'clause_noun_opt' => 'clause_noun'
  rule 'clause_noun_opt' => []
  rule 'clause_noun' => 'comparative_clause'
  rule 'clause_noun' => 'dependent_clause'


  #############
  # DETERMINERS
  #############
  rule 'determiners' => 'predeterminers central_determiners postdeterminers'

  # Pre-determiners
  rule 'predeterminers' => 'IndefiniteQuantifier' # all, ... both, half
  rule 'predeterminers' => 'partitive_predeterminer'
  rule 'predeterminers' => []

  rule 'partitive_predeterminer' => 'numeral PrepositionOf' # one of ...
  rule 'partitive_predeterminer' => 'IndefiniteQuantifier PrepositionOf' # some of...

  # Central determiners: article, demonstrative or possessive
  rule 'central_determiners' => 'article'
  rule 'central_determiners' => 'demonstrative'
  rule 'central_determiners' => 'PossessiveDeterminer'
  rule 'central_determiners' => []
  rule 'article' => 'DefiniteArticle' # 'the'
  rule 'article' => 'IndefiniteArticle' # 'a/an', .., any, some, that, those,
  rule 'demonstrative' => 'DemonstrativeDeterminer' # 'this', .., that, these, those
  # possessive => possessive_determiner # ...my, your, his, her, its, our, their

  # Postdeterminers
  rule 'postdeterminers' => 'numeral'
  rule 'postdeterminers' => []

  #############
  # VERB PHRASE
  #############
  rule 'verb_phrase' => 'pre_head_vp head_vp post_head_vp'
  # Rule specific to linking/copular verbs (CEG 288b). Example: I feel very bad.
  rule 'verb_phrase' => 'pre_head_vp linking_verb adjective_phrase'
  rule 'pre_head_vp' => 'adverb_phrase_opt'
  rule 'head_vp' => 'lexical_verb'
  rule 'head_vp' => 'IrregularVerbSay direct_speech'
  rule 'head_vp' => 'RegularVerbWant Preposition head_vp post_head_vp'

  # Cover case where ´that´ conjunction is dropped.
  rule 'head_vp' => 'mental_verb dependent_clause'
  # ex. 2-23c
  rule 'head_vp' => 'mental_verb identifying_clause'

  rule 'post_head_vp' => 'noun_phrase_opt adverb_phrase_opt prepositional_phrases adverb_phrase_opt'
  rule 'lexical_verb' => 'RegularVerb'
  rule 'lexical_verb' => 'RegularVerbWant'
  rule 'lexical_verb' => 'IrregularVerb'
  rule 'lexical_verb' => 'IrregularLinkingVerb'
  rule 'lexical_verb' => 'IrregularVerbBe'
  rule 'lexical_verb' => 'IrregularVerbDo'
  rule 'lexical_verb' => 'IrregularVerbHave'
  rule 'lexical_verb' => 'IrregularVerbKnow'
  rule 'lexical_verb' => 'IrregularVerbSay'
  rule 'lexical_verb' => 'IrregularVerbThink'


  rule 'linking_verb' => 'IrregularLinkingVerb'

  rule 'mental_verb' => 'IrregularVerbKnow'
  rule 'mental_verb' => 'IrregularVerbThink'
  rule 'direct_speech' => 'Colon Quote prose Quote'
  rule 'direct_speech' => 'Preposition noun_phrase Colon Quote declarative_simple_sentence Period Quote'
  rule 'direct_speech' => 'Colon declarative_simple_sentence'

  ##################
  # ADJECTIVE PHRASE
  ##################
  rule 'adjective_phrase_opt' => 'adjective_phrase'
  rule 'adjective_phrase_opt' => []
  rule 'adjective_phrase' => 'premodifiers_adj head_adjective postmodifiers_adj'
  rule 'premodifiers_adj' => 'adverb_phrase_opt'
  rule 'head_adjective' => 'head_adjective Adjective' # sequence of adjectives (rem: could be comma separated or anded)
  rule 'head_adjective' => 'Adjective'
  rule 'postmodifiers_adj' => 'prepositional_phrase' # TODO: multiple prepositional phrases, gerund and to + infinitive
  # Adverbs such as enough, indeed can post-modify an adjective
  rule 'postmodifiers_adj' => []

  ################
  # ADJVERB PHRASE
  ################
  rule 'adverb_phrase_opt' => 'adverb_phrase'
  rule 'adverb_phrase_opt' => []
  rule 'adverb_phrase' => 'premodifiers_adv head_adverb'
  rule 'premodifiers_adv' => 'adverb_occurrence'
  rule 'premodifiers_adv' => []
  rule 'head_adverb' => 'adverb_occurrence'
  rule 'adverb_occurrence' => 'Adverb'
  rule 'adverb_occurrence' => 'DegreeAdverb'
  rule 'adverb_occurrence' => 'LinkingAdverb'


  ######################
  # PREPOSITIONAL PHRASE
  ######################
  rule 'prepositional_phrases' => 'prepositional_phrases prepositional_phrase'
  rule 'prepositional_phrases' => []
  rule 'prepositional_phrase' => 'premodifier_prep preposition_head preposition_object'
  # premodifier_prep =>  # "A degree word" example 1: _straight_ across the street example 2: _right_ from the start
  rule 'premodifier_prep' => []
  rule 'preposition_head' => 'Preposition'
  rule 'preposition_head' => 'PrepositionOf'
  rule 'preposition_object' => 'noun_phrase' # (noun and pronoun)

  # complementation by a verb: gerund -ing form...
  rule 'preposition_object' => 'noun_phrase_opt lexical_verb post_head_vp'
  # preposition_object => "a gerund (a verb form ending in "-ing") that acts as a noun # Example: He beat Lee without overly trying.
  rule 'preposition_object' => 'conjunctive_prefix'		# It's obvious from _what he said_.
  rule 'preposition_object' => []

  ######################
  # REMAINING RULES
  ######################
  rule 'numeral' => 'Cardinal'
end

# And now build the grammar...
ZenlishGrammar = builder.grammar
