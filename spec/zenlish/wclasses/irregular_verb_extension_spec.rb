# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework

# Load the class under test
require_relative '../../../lib/zenlish/wclasses/irregular_verb_extension'

module Zenlish
  module WClasses
    describe IrregularVerbExtension do
      subject do
        obj = Object.new
        obj.extend(IrregularVerbExtension)
        obj.init_extension(obj)
        obj
      end

      context 'Initialization:' do
        it 'should mix-in with a host object' do
          expect { Object.new.extend(IrregularVerbExtension) }.not_to raise_error
        end

        it 'should inject an instance variable' do
          expect(subject.instance_variable_get(:@forms)).to be_kind_of(Array)
        end
      end # context

      context 'Provided services:' do
        it 'should provide a write accessor' do
          subject.forms past_simple: 'chose', past_participle: 'chosen'
          expect(subject.past_simple).to eq('chose')
          expect(subject.past_participle).to eq('chosen')
        end
      end # context
    end # describe
  end # module
end # module
