# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/wclasses/noun' # Load the class under test

module Zenlish
  module WClasses
    describe Noun do
      subject { Noun.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { Noun.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'should know that it is variable (has inflected forms)' do
          expect(subject).not_to be_invariable
        end

        it 'should know its feature names' do
          expectations = %w(NUMBER COUNTABILITY)
          expectations.each do |name|
            expect(subject[name]).not_to be_nil
          end
        end
      end # context
    end # describe
  end # module
end # module
