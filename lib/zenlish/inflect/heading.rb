# frozen_string_literal: true

require_relative '../feature/feature'
require_relative '../feature/feature_def'

module Zenlish
  module Inflect
    class Heading
      attr_reader :label

      def initialize(aLabel)
        @label = aLabel
      end
    end # class
  end # module
end # module
