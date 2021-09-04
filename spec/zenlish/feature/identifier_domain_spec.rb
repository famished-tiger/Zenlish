# frozen_string_literal: true

require_relative '../../../lib/zenlish/feature/identifier_domain' # Load the class under test

module Zenlish
  module Feature
    describe IdentifierDomain do
      subject { IdentifierDomain.instance }

      context 'Initialization:' do
        it 'should be instantiated without argument' do
          expect { IdentifierDomain.instance }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'should know whether a value is in domain' do
          expect(subject.include?('CommonForm')).to be_truthy
          expect(subject.include?('Common Form')).to be_falsey
          expect(subject.include?('+123')).to be_falsey
        end

        it 'should provide a factory method for identifier values' do
          expect(subject.build_value('CommonForm')).to be_kind_of(IdentifierValue)
          expect(subject.build_value('Common_Form')).to be_kind_of(IdentifierValue)
        end

        it 'should complain when asked to build an invalid identifier' do
          err = StandardError
          err_msg = "?1234 isn't a valid identifier."
          expect { subject.build_value('?1234') }.to raise_error(err, err_msg)
        end
      end # context
    end # describe
  end # module
end # module
