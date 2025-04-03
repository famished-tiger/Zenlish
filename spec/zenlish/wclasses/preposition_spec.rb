# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/wclasses/preposition' # Load the class under test

module Zenlish
  module WClasses
    describe Preposition do
      subject(:preposition) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'is invariable' do
          expect(preposition).to be_invariable
        end
      end # context
    end # describe
  end # module
end # module
