# frozen_string_literal: true

require_relative '../../../lib/zenlish/feature/boolean_domain'
require_relative '../../../lib/zenlish/feature/boolean_value' # Load the class under test

module Zenlish
  module Feature
    describe BooleanValue do
      let(:its_value) { false }

      subject(:boolean) { described_class.new(its_value) }

      context 'Initialization:' do
        it 'is initialized with a value argument' do
          expect { described_class.new(its_value) }.not_to raise_error
        end

        it 'knows its internal value' do
          expect(boolean.val.class).to eq(FalseClass)
        end
      end # context

      context 'Provided services:' do
      end # context
    end # describe
  end # module
end # module
