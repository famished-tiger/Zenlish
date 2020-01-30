# frozen_string_literal: true

require_relative '../../../lib/zenlish/feature/boolean_domain'
require_relative '../../../lib/zenlish/feature/boolean_value' # Load the class under test

module Zenlish
  module Feature
    describe BooleanValue do
      let(:its_value) { false }
      subject { BooleanValue.new(its_value) }

      context 'Initialization:' do
        it 'should be initialized with a value argument' do
          expect { BooleanValue.new(its_value) }.not_to raise_error
        end
        
        it 'should know its internal value' do
          expect(subject.val.class).to eq(FalseClass)
        end
      end # context

      context 'Provided services:' do
      end # context
    end # describe
  end # module
end # module
