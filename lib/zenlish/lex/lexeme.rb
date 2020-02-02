require_relative '../feature/feature_struct_def_bearer'
module Zenlish
  module Lex
    # A word in the abstract sense; an individual, distinct item of a lexicon
    # that belongs to a word class and of which a number of actual word forms
    # may exist. For instance, the word forms: 'hide', 'hides', 'hid', 'hidden'
    # relate to the lexeme for verb 'hide'. Also called 'dictionary word'.
    class Lexeme
      include Feature::FeatureStructDefBearer

      # @return [Zenlish::WClasses::WordClass] the word class to which the lexeme belongs
      attr_reader :wclass

      # @param aWClass [WClasses::WordClass, Rley::Syntax::Terminal]
      # @param anEntry [Zenlish::LexicalEntry]
      # @param aFeatureHash [Hash, NilClass]
      def initialize(aWClass, anEntry, aFeatureHash = nil)
        @wclass = aWClass
        @entry = anEntry.object_id
        anEntry.add_lexeme(self)

        p_struct = aWClass.kind_of?(WClasses::WordClass) ? aWClass.struct : nil
        overriding_struct_defs = aFeatureHash.nil? ? {} : aFeatureHash
        init_struct_def(p_struct, overriding_struct_defs)
      end

      # @return [Zenlish::Lex::LexicalEntry] Link to its dictionary entry (headword)
      def entry
        ObjectSpace._id2ref(@entry)
      end

      # Inflect the lexeme according the default paradigm of the word class.
      # @param constraints [Array] Array of values (for each heading of inflection table
      # @return [String] The word form (spelling) inflected to the given contraints.
      def inflect(constraints)
        table = paradigm
        table.inflect(self, constraints)
      end

      # @return [String] the base (dictionary) form.
      def lemma
        entry.lemma
      end

      # Return the inflection paradigm for the lexeme.
      # @return [Inflect::InflectionTable]
      def paradigm
        paradigm_feat_def = self['PARADIGM']
        wclass.paradigms[paradigm_feat_def.default.val]
      end

      alias base_form lemma
    end # class
  end # module
end # module