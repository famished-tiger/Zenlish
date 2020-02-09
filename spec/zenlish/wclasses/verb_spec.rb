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
      subject { Verb.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { Verb.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'should know that it has inflected forms' do
          expect(subject).not_to be_invariable
        end

        it 'should know its feature definitions' do
          expect(subject['NUMBER']).to be_kind_of(Feature::FeatureDef)
          expect(subject['PERSON']).to be_kind_of(Feature::FeatureDef)
          expect(subject['PARADIGM'].default.val).to eq('Regular_inflection')
        end
      end # context
    end # describe
  end # module
end # module
