# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/wclasses/verb' # Load the class under test

module Zenlish
  module WClasses
    describe Verb do
      subject { Verb.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { Verb.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'should know that it it is variable (has inflected forms)' do
          expect(subject).not_to be_invariable
        end
      end # context
    end # describe
  end # module
end # module
