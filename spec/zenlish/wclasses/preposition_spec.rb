# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/wclasses/preposition' # Load the class under test

module Zenlish
  module WClasses
    describe Preposition do
      subject { Preposition.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { Preposition.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'should know that it is invariable' do
          expect(subject).to be_invariable
        end
      end # context
    end # describe
  end # module
end # module
