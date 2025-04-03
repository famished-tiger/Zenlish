# frozen_string_literal: true

# Load the class under test
require_relative '../../../lib/zenlish/inflect/method_heading'

module Zenlish
  module Inflect
    describe MethodHeading do
      let(:method_name) { 'base_form' }

      subject(:heading) { described_class.new(method_name) }

      context 'Initialization:' do
        it 'is initialized with a method name' do
          expect { described_class.new(method_name) }.not_to raise_error
        end

        it 'knows its label' do
          expect(heading.label).to eq(method_name)
        end
      end # context

      context 'Provided services:' do
        it 'obtains the method result from a word' do
          mocked = double('dummy-lexeme')
          allow(mocked).to receive(:base_form).and_return('cherry')
          expect(heading.evaluate_for(mocked)).to eq('cherry')
        end

        it 'obtains the method result as an array' do
          mocked = double('dummy-lexeme')
          allow(mocked).to receive(:base_form).and_return('cherry')
          expect(heading.all_matches(mocked)).to eq(['cherry'])
        end
      end # context
    end # describe
  end # module
end # module
