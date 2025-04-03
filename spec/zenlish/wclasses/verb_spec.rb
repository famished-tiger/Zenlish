# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/wclasses/verb' # Load the class under test

module Zenlish
  module WClasses
    class Verb
      # Do limited monkeypatching, just for testing purposes
      def init_paradigms
        # Empty method
      end
    end

    describe Verb do
      subject(:a_verb) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'knows that it has inflected forms' do
          expect(a_verb).not_to be_invariable
        end

        it 'knows its feature definitions' do
          expect(a_verb['NUMBER']).to be_a(Feature::FeatureDef)
          expect(a_verb['PERSON']).to be_a(Feature::FeatureDef)
          expect(a_verb['PARADIGM'].default.val).to eq('Regular_inflection')
        end
      end # context
    end # describe
  end # module
end # module
