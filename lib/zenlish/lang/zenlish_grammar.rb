# Grammar for a simple subset of English language
# It is called Zenlish

require 'rley' # Load the Rley parsing library
require_relative 'dictionary'

########################################
# Define a grammar for a highly English-like language
builder = Rley::Syntax::GrammarBuilder.new do
  add_terminals(*Zenlish::Lang::Dictionary.terminals)

  rule 'zenlish' => 'prose'
  rule 'prose' => 'sentence Period'
  rule 'prose' => 'prose sentence Period'

  rule 'sentence' => 'simple_sentence'
  rule 'sentence' => 'complex_sentence'

  #################
  # Simple sentence
  #################
  rule 'simple_sentence' =>  'front_adverb simple_sentence'
  rule 'front_adverb' => 'AdverbMaybe'
  rule 'front_adverb' => 'Adverb'
  rule 'simple_sentence' => 'declarative_simple_sentence'
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

  rule 'predicative_sentence' => 'noun_phrase affirmation'
  rule 'predicative_sentence' => 'conjunctive_prefix affirmation'
  rule 'negated_predicate_sentence' => 'noun_phrase adverb_phrase_opt negation'
  rule 'negated_predicate_sentence' => 'conjunctive_prefix negation'
  rule 'affirmation' => 'IrregularVerbBe predicative_complement'
  rule 'negation' => 'IrregularVerbBe AdverbNot predicative_complement'
  rule 'predicative_complement' => 'noun_phrase'
  # 3-22b:  X is not the same as before.
  rule 'predicative_complement' => 'noun_phrase ComparativeParticle Adverb'
  rule 'predicative_complement' => 'adjective_phrase comparative_clause_opt'
  # 3-02d J is one that does this.
  rule 'predicative_complement' => 'adjective_phrase relative_clause_opt'
  # 2-28b X is alive before this moment.
  rule 'predicative_complement' => 'adjective_phrase adverb_phrase noun_phrase_opt'
  # X is far from the start.
  rule 'predicative_complement' => 'adverb_phrase_opt prepositional_phrase'
  # something that was not here before.
  rule 'predicative_complement' => 'adverb_phrase_star'

  #################
  # Complex sentence
  #################
  # Case of dropped ´that´ conjunction
  rule 'complex_sentence' => 'AdverbMaybe complex_sentence'
  rule 'complex_sentence' => 'main_clause comma_opt subordinated_clause'
  rule 'complex_sentence' => 'main_clause comma_opt relative_clause'
  rule 'complex_sentence' => 'main_clause comma_opt coordinate_clause'
  # 3-22d: ..., it changed what I thought about them.
  rule 'complex_sentence' => 'main_clause conjunctive_prefix'
  # 3-22d: I cannot see what is inside.
  rule 'complex_sentence' => 'main_clause ConjunctivePronoun verb_phrase'
  rule 'complex_sentence' => 'subordinated_clause Comma main_clause'
  # 3-03b If J is not true, then K is true.
  rule 'complex_sentence' => 'subordinated_clause Comma LinkingAdverb main_clause'
  # CGE 287d: verb + direct object + infinitive clause (without to)
  rule 'complex_sentence' => 'main_clause infinitive_clause'
  # Colon used to introduce an explanatory sentence.
  rule 'complex_sentence' => 'main_clause Colon sentence'
  rule 'comma_opt' => 'Comma'
  rule 'comma_opt' => []

  ######################
  # CLAUSES
  ######################
  rule 'main_clause' => 'sentence'
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
  rule 'identifying_clause' => 'RelativePronoun tense_verb_phrase'
  rule 'relative_clause_opt' =>  'relative_clause'
  rule 'relative_clause_opt' => []
  rule 'relative_clause' => 'RelativePronoun tense_phrase'
  # Sentence 3-Bxa 'Lisa sees a living thing that is very big.
  rule 'relative_clause' => 'RelativePronoun affirmation'
  # Sentence 3-18b: something that was not here before.
  rule 'relative_clause' => 'RelativePronoun negation'
  rule 'relative_clause' => 'identifying_clause'
  rule 'coordinate_clause' => 'Coordinator simple_sentence'
  # Sentence 3-11b K happens because J happens or because J does something.
  rule 'coordinate_clause' => 'Coordinator subordinated_clause'

  # Implicit subject. 3-05b: I saw this thing and touched some of its parts.
  rule 'coordinate_clause' => 'Coordinator tense_verb_phrase'


  ##############
  # TENSE PHRASE
  ##############
  # Leading adverb phrase: now I see it. now is an adjunct)
  rule 'tense_phrase' => 'adverb_phrase_opt noun_phrase tense_verb_phrase'
  rule 'negative_tense_phrase' => 'noun_phrase negative_tense_verb_phrase'
  rule 'tense_verb_phrase' => 'tense_opt verb_phrase'
  rule 'negative_tense_verb_phrase' => 'tense_opt AdverbNot verb_phrase'
  rule 'tense_opt' => 'tense'
  rule 'tense_opt' => []
  rule 'tense' => 'AuxiliaryBe'
  rule 'tense' => 'AuxiliaryDo'
  rule 'tense' => 'ModalVerbCan'
  rule 'tense' => 'ModalVerbCould'

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
  rule 'head_np' => 'Pronoun'
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
  rule 'determiners' => 'predeterminer_opt central_determiner_opt postdeterminers'
  rule 'determiners' => 'partitive_determiner PrepositionOf main_determiner_opt postdeterminers'

  # Pre-determiner
  rule 'predeterminer_opt' => 'predeterminer'
  rule 'predeterminer_opt' => []
  rule 'predeterminer' => 'FrontingQuantifier' # all, both
  # FOR_LATER 'predeterminer' => 'multipler' # twice, thrice, n times
  # FOR_LATER 'predeterminer' => 'fraction' # half, third, ...
  # FOR_LATER 'predeterminer' => 'intensifier' # what (exclamative), such, quite, rather

  # Central determiners: article, demonstrative or possessive
  rule 'central_determiner_opt' => 'main_determiner'
  rule 'central_determiner_opt' => 'DistributiveDeterminer' # each, every, either, neither
  # FOR_LATER 'central_determiner_opt' => 'InterrogativeDeterminer' # what, which, whose
  rule 'central_determiner_opt' => []
  rule 'main_determiner_opt' => 'main_determiner'
  rule 'main_determiner_opt' => []
  rule 'main_determiner' => 'article'
  rule 'main_determiner' => 'DemonstrativeDeterminer' # 'this', .., that, these, those
  rule 'main_determiner' => 'PossessiveDeterminer' # my, your, his, her, its, our, their
  rule 'article' => 'DefiniteArticle' # 'the'
  rule 'article' => 'IndefiniteArticle' # 'a/an', .., any, some, that, those,

  # Post-determiners
  # FOR_LATER 'postdeterminers' => 'ordinal_opt cardinal_opt other_quantifiers'
  # Example 3-14b: There are two or more things.
  rule 'postdeterminers' => 'postdeterminers Coordinator postdeterminers'
  rule 'postdeterminers' => 'cardinal_opt other_quantifiers'
  rule 'postdeterminers' => []
  rule 'other_quantifiers' => 'other_quantifiers Quantifier'
  rule 'other_quantifiers' => []

  rule 'partitive_determiner' => 'predeterminer'
  rule 'partitive_determiner' => 'DistributiveDeterminer'
  # FOR_LATER 'partitive_determiner' => 'Ordinal'
  # FOR_LATER 'partitive_determiner' => 'GeneralOrdinal'
  rule 'partitive_determiner' => 'Cardinal'
  rule 'partitive_determiner' => 'Quantifier'

  #############
  # VERB PHRASE
  #############
  rule 'verb_phrase' => 'pre_head_vp head_vp post_head_vp'
  # Rule specific to linking/copular verbs (CEG 288b). Example: I feel very bad.
  rule 'verb_phrase' => 'pre_head_vp linking_verb adjective_phrase'
  # Sentence 3-12b: Maybe when some people hear J is true
  rule 'verb_phrase' => 'pre_head_vp linking_verb dependent_clause'
  rule 'pre_head_vp' => 'adverb_phrase_opt'
  rule 'head_vp' => 'lexical_verb'
  rule 'head_vp' => 'IrregularVerbSay direct_speech'
  rule 'head_vp' => 'RegularVerbWant Preposition head_vp post_head_vp'

  # Cover case where ´that´ conjunction is dropped.
  rule 'head_vp' => 'mental_verb dependent_clause'
  # 3-21b: ...that you think can cause X to happen.
  rule 'head_vp' => 'mental_verb tense_verb_phrase'
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
  rule 'direct_speech' => 'Colon sentence'

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
  rule 'adverb_phrase_star' => 'adverb_phrase_star adverb_phrase'
  rule 'adverb_phrase_star' => []
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
  rule 'cardinal_opt' => 'Cardinal'
  rule 'cardinal_opt' => []
  rule 'numeral' => 'Cardinal'
end

# And now build the grammar...
ZenlishGrammar = builder.grammar
