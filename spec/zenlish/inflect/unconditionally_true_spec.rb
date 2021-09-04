# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/inflect/unconditionally_true'

module Zenlish
  module Inflect
    describe UnconditionallyTrue do
      let(:method_name) { 'base_form' }
      subject { UnconditionallyTrue.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { UnconditionallyTrue.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'should always return true' do
          headings = double('dummy-headings')
          lexeme = double('dummy-lexeme')
          values = double('dummy-heading-values')
          expect(subject.success?(headings, lexeme, values)).to be_truthy
        end
      end # context
    end # describe
  end # module
end # module
