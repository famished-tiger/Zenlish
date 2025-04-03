# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/inflect/unconditionally_true'

module Zenlish
  module Inflect
    describe UnconditionallyTrue do
      let(:method_name) { 'base_form' }

      subject(:u_true) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'always return true' do
          headings = double('dummy-headings')
          lexeme = double('dummy-lexeme')
          values = double('dummy-heading-values')
          # expect(u_true.success?(headings, lexeme, values)).to be_truthy
          expect(u_true).to be_success(headings, lexeme, values)
        end
      end # context
    end # describe
  end # module
end # module
