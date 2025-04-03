# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../support/var2word'
require_relative '../../../lib/zenlish/parser/zparser' # Load the class under test

module Zenlish
  module Parser
    describe ZParser do
      include Var2Word

      subject(:parser) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end
      end # context

      context 'Producing parse tree or forest:' do
        # it 'should produce trees (for non ambiguous input)' do
          # # OK, non-ambiguous sentence: "Lisa sees Tony."
          # literals = [lisa, sees, tony, dot]
          # result_type = Rley::PTree::ParseTree
          # expect(parser.to_pforest(literals)).to be_a(result_type)
        # end

        it 'produces forest' do
          # Sentence: "Lisa sees Tony."
          literals = [lisa, sees, tony, dot]
          result_type = Rley::SPPF::ParseForest
          expect(parser.to_pforest(literals)).to be_a(result_type)
        end
      end # context
    end # describe
  end # module
end # module
