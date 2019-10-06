# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/wclasses/irregular_verb' # Load the class under test

module Zenlish
  module WClasses
    describe IrregularVerb do
      subject { IrregularVerb.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { IrregularVerb.new }.not_to raise_error
        end
      end # context

      # context 'Provided services:' do
      # end # context
    end # describe
  end # module
end # module
