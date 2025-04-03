# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework

# Load the class under test
require_relative '../../../lib/zenlish/wclasses/irregular_verb_extension'

module Zenlish
  module WClasses
    describe IrregularVerbExtension do
      subject(:verb) do
        obj = Object.new
        obj.extend(described_class)
        obj.init_extension(obj)
        obj
      end

      context 'Initialization:' do
        it 'allows mix-in with a host object' do
          expect { Object.new.extend(described_class) }.not_to raise_error
        end

        it 'injects an instance variable' do
          expect(verb.instance_variable_get(:@forms)).to be_a(Array)
        end
      end # context

      context 'Provided services:' do
        it 'provides a write accessor' do
          verb.forms past_simple: 'chose', past_participle: 'chosen'
          expect(verb.past_simple).to eq('chose')
          expect(verb.past_participle).to eq('chosen')
        end
      end # context
    end # describe
  end # module
end # module
