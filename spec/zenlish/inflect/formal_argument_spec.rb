# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/inflect/formal_argument'

module Zenlish
  module Inflect
    describe FormalArgument do
      subject(:arg) { described_class.new(3) }

      context 'Initialization:' do
        it 'is initialized with a text literal' do
          expect { described_class.new(1) }.not_to raise_error
        end

        it 'knows its index value' do
          expect(arg.index).to eq(3)
        end
      end # context

      context 'Provided services:' do
      end # context
    end # describe
  end # module
end # module
