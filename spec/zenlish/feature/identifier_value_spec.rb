# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/feature/identifier_value' 

module Zenlish
  module Feature
    describe IdentifierValue do
      let(:its_value) { 'CommonForm' }
      subject { IdentifierValue.new(its_value) }

      context 'Initialization:' do
        it 'should be initialized with a value argument' do
          expect { IdentifierValue.new(its_value) }.not_to raise_error
        end
        
        it 'should know its internal value' do
          expect(subject.val).to eq(its_value)
        end        
      end # context

      context 'Provided services:' do
      end # context
    end # describe
  end # module
end # module