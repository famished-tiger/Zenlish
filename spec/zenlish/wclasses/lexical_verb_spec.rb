# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework

# Load the class under test
require_relative '../../../lib/zenlish/wclasses/lexical_verb'

module Zenlish
  module WClasses
    class LexicalVerb
      # Do limited monkeypatching, just for testing purposes
      def init_paradigms
        # Empty method
      end
    end

    describe LexicalVerb do
      subject(:verb) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'knows its inherited feature definitions' do
          expect(verb['NUMBER']).to be_a(Feature::FeatureDef)
          expect(verb['PERSON']).to be_a(Feature::FeatureDef)
          expect(verb['PARADIGM'].default.val).to eq('Regular_inflection')
        end
      end # context
    end # describe
  end # module
end # module
