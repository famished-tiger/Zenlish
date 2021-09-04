# frozen_string_literal: true

require 'ostruct'
# Load the class under test
require_relative '../../../lib/zenlish/inflect/function_call'

module Zenlish
  module Inflect
    describe FunctionCall do
      subject { FunctionCall.new('greet') }

      context 'Initialization:' do
        it 'should be initialized with a text literal' do
          expect { FunctionCall.new('greet') }.not_to raise_error
        end

        it 'should know its method name' do
          expect(subject.mth_name).to eq('greet')
        end
      end # context

      context 'Provided services:' do
        it 'should return the affix during word form generation' do
          headings = double('fake-headings')
          lexeme = OpenStruct.new(greet: 'Hello, world')
          values = double('fake-values')
          expect(subject.generate(headings, lexeme, values)).to eq('Hello, world')
        end
      end # context
    end # describe
  end # module
end # module
