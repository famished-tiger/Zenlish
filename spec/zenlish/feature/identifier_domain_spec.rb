# frozen_string_literal: true

require_relative '../../../lib/zenlish/feature/identifier_domain' # Load the class under test

module Zenlish
  module Feature
    describe IdentifierDomain do
      subject(:domain) { described_class.instance }

      context 'Initialization:' do
        it 'is instantiated without argument' do
          expect { described_class.instance }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'knows whether a value is in domain' do
          expect(domain).to include('CommonForm')
          expect(domain).not_to include('Common Form')
          expect(domain).not_to include('+123')
        end

        it 'provides a factory method for identifier values' do
          expect(domain.build_value('CommonForm')).to be_a(IdentifierValue)
          expect(domain.build_value('Common_Form')).to be_a(IdentifierValue)
        end

        it 'complains when asked to build an invalid identifier' do
          err = StandardError
          err_msg = "?1234 isn't a valid identifier."
          expect { domain.build_value('?1234') }.to raise_error(err, err_msg)
        end
      end # context
    end # describe
  end # module
end # module
