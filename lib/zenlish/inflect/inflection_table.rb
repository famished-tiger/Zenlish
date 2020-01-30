
module Zenlish
  module Inflect
    class InflectionTable
      attr_reader :name
      attr_reader :headings
      attr_reader :rules

      def initialize(aName)
        @name = aName
        @headings = []
        @rules = []
      end

      def add_heading(aHeading)
        @headings << aHeading
      end

      def add_rule(aRule)
        @rules << aRule
      end

      def inflect(aLexeme, theConstraints)
        err_msg = "Table has #{headings.size} headings."
        raise StandardError, err_msg if theConstraints.size != headings.size
        actuals = []
        headings.each_with_index do |hd, idx|
          if theConstraints[idx]
            actuals << theConstraints[idx]
          else
            actuals << hd.evaluate_for(aLexeme)
          end
        end
        # Hit policy: first
        matching_rule = rules.find do |rule| 
          rule.success?(headings, aLexeme, actuals) 
        end
        unless matching_rule
          err_msg = "No rule in table covers case: lexeme #{aLexeme}, actuals: #{p actuals}."
          raise StandardError, err_msg
        end
        matching_rule.apply(headings, aLexeme, actuals)
      end
    end # class
  end # module
end # module