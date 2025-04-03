# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/inflect/function_call'

module Zenlish
  module Inflect
    describe FunctionCall do
      subject(:func_call) { described_class.new('greet') }

      context 'Initialization:' do
        it 'is initialized with a text literal' do
          expect { described_class.new('greet') }.not_to raise_error
        end

        it 'knows its method name' do
          expect(func_call.mth_name).to eq('greet')
        end
      end # context

      context 'Provided services:' do
        it 'returns the affix during word form generation' do
          headings = double('fake-headings')
          lexeme = double('fake-lexeme', greet: 'Hello, world')
          values = double('fake-values')
          expect(func_call.generate(headings, lexeme, values)).to eq('Hello, world')
        end
      end # context
    end # describe
  end # module
end # module
