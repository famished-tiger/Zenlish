# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/wclasses/noun' # Load the class under test

module Zenlish
  module WClasses
    describe Noun do
      subject(:noun) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'knows that it is variable (has inflected forms)' do
          expect(noun).not_to be_invariable
        end

        it 'knows its feature names' do
          expectations = %w(NUMBER COUNTABILITY)
          expectations.each do |name|
            expect(noun[name]).not_to be_nil
          end
        end
      end # context
    end # describe
  end # module
end # module
