# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/inflect/formal_argument'

module Zenlish
  module Inflect
    describe FormalArgument do
      subject { FormalArgument.new(3) }

      context 'Initialization:' do
        it 'should be initialized with a text literal' do
          expect { FormalArgument.new(1) }.not_to raise_error
        end

        it 'should know its index value' do
          expect(subject.index).to eq(3)
        end
      end # context

      context 'Provided services:' do
      end # context
    end # describe
  end # module
end # module
