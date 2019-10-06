# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework

# Load module under test
require_relative '../../../lib/zenlish/lex/empty_lexicon_factory'

module Zenlish
  module Lex
    describe EmptyLexiconFactory do
      subject do
        obj = Object.new
        obj.extend(EmptyLexiconFactory)
      end

      context 'Mix-in integration:' do
        it 'should acquire the methods of the mix-in module' do
          expect(subject.respond_to?(:create_empty_lexicon)).to be_truthy
        end
      end # context

      context 'Created lexicon:' do
        it 'should allow the creation of empty lexicon' do
          expect(subject.create_empty_lexicon).to be_kind_of(Lexicon)
        end

        it 'should initialize lexicon with terminal symbols of the language' do
          lexicon = subject.create_empty_lexicon
          found = lexicon.terminals.find { |symb| symb.kind_of?(WClasses::CommonNoun) }
          expect(found).to be_truthy
        end
      end # context
    end # describe
  end # module
end # module
