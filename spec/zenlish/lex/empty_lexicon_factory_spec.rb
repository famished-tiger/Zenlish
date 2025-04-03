# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework

# Load module under test
require_relative '../../../lib/zenlish/lex/empty_lexicon_factory'

module Zenlish
  module Lex
    describe EmptyLexiconFactory do
      subject(:factory) do
        obj = Object.new
        obj.extend(described_class)
      end

      context 'Mix-in integration:' do
        it 'acquires the methods of the mix-in module' do
          expect(factory).to respond_to(:create_empty_lexicon)
        end
      end # context

      context 'Created lexicon:' do
        it 'allows the creation of empty lexicon' do
          expect(factory.create_empty_lexicon).to be_a(Lexicon)
        end

        it 'initializes lexicon with terminal symbols of the language' do
          lexicon = factory.create_empty_lexicon
          found = lexicon.terminals.find { |symb| symb.kind_of?(WClasses::CommonNoun) }
          expect(found).to be_truthy
        end
      end # context
    end # describe
  end # module
end # module
