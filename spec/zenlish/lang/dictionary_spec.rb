# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/wclasses/common_noun'
require_relative '../../../lib/zenlish/lang/dictionary' # Load the class under test

module Zenlish
  module Lang
    describe Dictionary do
      subject { Dictionary }

      context 'Provided services:' do
        let(:common_nouns) do
          # Some Zenlish common nouns
          %w( animal body container here kind machine moment now part people
              person place side surface thing time word)
        end

        it 'should give the list of common nouns' do
          lexemes = []
          subject.entries.each do |ent|
            lexm = ent.lexemes.select { |lx| lx.wclass.kind_of?(Zenlish::WClasses::CommonNoun) }
            lexemes.concat(lexm) if lexm
          end
          lemmas = lexemes.map { |lx| lx.entry.lemma }

          expect(common_nouns.all? { |c_n| lemmas.include?(c_n) }).to be_truthy
        end

      end # context
    end # describe
  end # module
end # module