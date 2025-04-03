# frozen_string_literal: true

require_relative '../../../lib/zenlish/feature/boolean_domain' # Load the class under test

module Zenlish
  module Feature
    describe BooleanDomain do
      subject(:bool_dom) { described_class.instance }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.instance }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'knows whether a value is in domain' do
          expect(bool_dom).not_to include('invalid')
          expect(bool_dom).to include(true)
          expect(bool_dom).to include(false)
        end

        it 'provides a factory method for boolean values' do
          expect(bool_dom.build_value(true)).to be_a(BooleanValue)
          expect(bool_dom.build_value(false)).to be_a(BooleanValue)
        end

        it 'returns all valid values in domain when requested' do
          expect(bool_dom.to_a).to eq([false, true])
        end

        it 'complains when asked to build a non-boolean value' do
          err = StandardError
          err_msg = 'Expected a boolean instead of String.'
          expect { bool_dom.build_value('?') }.to raise_error(err, err_msg)
        end
      end # context
    end # describe
  end # module
end # module
