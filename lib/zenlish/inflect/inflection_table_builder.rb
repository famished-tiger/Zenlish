require_relative 'feature_heading'
require_relative 'method_heading'
require_relative 'formal_argument'
require_relative 'equals_literal'
require_relative 'not_equals_literal'
require_relative 'unconditionally_true'
require_relative 'matches_pattern'
require_relative 'membership'
require_relative 'input_asis'
require_relative 'function_call'
require_relative 'concatenation'
require_relative 'substitution'
require_relative 'inflection_rule'
require_relative 'inflection_table'

        # DecisionTable: Common_form
        # | NUMBER   | .base_form      | Common_form                |
        # | singular | X               | base_form                  |
        # | plural   | ~ /[^aeiouy]y$/ | sub(base_form, /y$/, "ies")|
        # | plural   | X               | base_form + "s"            |
        # build('Common_form') do
        #   feature_heading 'NUMBER'
        #   method_heading  'base_form'
        #       | NUMBER          | base_form             | Common_form               |
        #   rule [equals(:singular), dont_care             ], col('base_form')
        #   rule [equals(:plural)  , matches(/[^aeiouy]y$/)], sub(col('base_form'), /y$/, 'ies')
        #   rule [equals(:plural)  , dont_care             ], concat(col('base_form'), 's')
        # end

module Zenlish
  module Inflect
    class InflectionTableBuilder
      # Name of decision table
      attr_reader :table
      attr_reader :headings
      attr_reader :conds
      attr_reader :rules

      def initialize
        reset
      end

      def build(aTableName, &aBlock)
        reset
        @table = InflectionTable.new(aTableName)
        instance_exec(&aBlock) if block_given?
        @table
      end

      def feature_heading(aFeatureName)
        hd = FeatureHeading.new(aFeatureName)
        headings << hd
        table.add_heading(hd) if table
      end

      def method_heading(aMethodName)
        hd = MethodHeading.new(aMethodName)
        headings << hd
        table.add_heading(hd) if table
      end

      def rule(conditions, consequent)
        @conds = []
        rl = InflectionRule.new(conditions.dup, consequent)
        rules << rl
        table.add_rule(rl) if table

        rl
      end

      def equals(aValue)
        arg = FormalArgument.new(conds.size)
        equality_cond = EqualsLiteral.new(arg, aValue)
        conds << equality_cond

        equality_cond
      end

      def not_equal(aValue)
        arg = FormalArgument.new(conds.size)
        inequality_cond = NotEqualsLiteral.new(arg, aValue)
        conds << inequality_cond

        inequality_cond
      end

      def in?(*theMembers)
        arg = FormalArgument.new(conds.size)
        membership_cond = Membership.new(arg, theMembers)
        conds << membership_cond

        membership_cond
      end

      def dont_care
        item = UnconditionallyTrue.new
        conds << item

        item
      end

      def literal(aLiteral)
        LiteralAsIs.new(aLiteral)
      end

      def col(aColName)
        col_index = headings.find_index { |hd| hd.label == aColName }
        err_msg = "Cannot find heading named '#{aColName}'."
        raise StandardError, err_msg if col_index.nil?
        formal = FormalArgument.new(col_index)
        InputAsIs.new(formal)
      end

      def matches(aPattern)
        arg = FormalArgument.new(conds.size)
        match_cond = MatchesPattern.new(arg, aPattern)
        conds << match_cond
        match_cond
      end

      def func(aFuncName)
        FunctionCall.new(aFuncName)
      end

      def sub(original, pattern, replacement)
        Substitution.new(original, pattern, replacement)
      end

      def concat(arg1, arg2)
        Concatenation.new(arg1, arg2)
      end

      private

      def reset()
        @table = nil
        @headings = []
        @conds = []
        @rules = []
      end

      # def do_it
        # @headings
      # end
    end # class
  end # module
end # module