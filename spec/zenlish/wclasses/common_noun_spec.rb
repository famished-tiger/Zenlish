# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/wclasses/common_noun' # Load the class under test

module Zenlish
  module WClasses
    describe CommonNoun do
      subject { CommonNoun.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { CommonNoun.new }.not_to raise_error
        end
      end # context

      # context 'Provided services:' do
      # end # context
    end # describe
  end # module
end # module

