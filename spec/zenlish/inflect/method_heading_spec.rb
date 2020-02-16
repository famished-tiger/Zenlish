# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/inflect/method_heading'

module Zenlish
  module Inflect
    describe MethodHeading do
      let(:method_name) { 'base_form' }
      subject { MethodHeading.new(method_name) }

      context 'Initialization:' do
        it 'should be initialized with a method name' do
          expect { MethodHeading.new(method_name) }.not_to raise_error
        end

        it 'should know its label' do
          expect(subject.label).to eq(method_name)
        end
      end # context

      context 'Provided services:' do
        it 'should obtain the method result from a word' do
          mocked = double('dummy-lexeme')
          expect(mocked).to receive(:base_form).and_return('cherry')
          expect(subject.evaluate_for(mocked)).to eq('cherry')
        end
        
        it 'should obtain the method result as an array' do
          mocked = double('dummy-lexeme')
          expect(mocked).to receive(:base_form).and_return('cherry')
          expect(subject.all_matches(mocked)).to eq(['cherry'])
        end        
      end # context
    end # describe
  end # module
end # module