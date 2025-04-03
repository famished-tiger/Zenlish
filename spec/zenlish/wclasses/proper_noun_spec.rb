# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/wclasses/proper_noun' # Load the class under test

module Zenlish
  module WClasses
    describe ProperNoun do
      subject { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end
      end # context

      # context 'Provided services:' do
      # end # context
    end # describe
  end # module
end # module
