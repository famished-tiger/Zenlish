# frozen_string_literal: true

require_relative '../../../lib/zenlish/feature/boolean_domain' # Load the class under test

module Zenlish
  module Feature
    describe BooleanDomain do
      subject { BooleanDomain.instance }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { BooleanDomain.instance }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'should know whether a value is in domain' do
          expect(subject.include?('invalid')).to be_falsey
          expect(subject.include?(true)).to be_truthy
          expect(subject.include?(false)).to be_truthy
        end

        it 'should provide a factory method for boolean values' do
          expect(subject.build_value(true)).to be_kind_of(BooleanValue)
          expect(subject.build_value(false)).to be_kind_of(BooleanValue)
        end
        
        it 'should return all valid values in domain when requested' do
          expect(subject.to_a).to eq([false, true])
        end         

        it 'should complain when asked to build a non-boolean value' do
          err = StandardError
          err_msg = 'Expected a boolean instead of String.'
          expect { subject.build_value('?') }.to raise_error(err, err_msg)
        end
      end # context
    end # describe
  end # module
end # module
