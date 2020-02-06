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

        let(:present_1sg) { [:first, :singular, :present, nil] }
        let(:present_3sg) { [:third, :singular, :present, nil] }
        let(:present_1pl) { [:first, :plural,   :present, nil] }
        let(:progressive) { [nil,    nil,       :progressive, nil] }
        let(:past_simple) { [nil,    nil,       :past_simple, nil] }
        let(:past_participle) { [nil, nil,      :past_participle, nil] }

        def test_inflection_of(verb_lexeme, pairs)
          pairs.each do |(constraints, expected_form)|
            expect(verb_lexeme.inflect(constraints)).to eq(expected_form)
          end
        end

        it 'should know how to inflect an (irregular) verb' do
          lexm = subject.get_lexeme('become')
          expectations_1 = [
            [present_1sg,     'become'],
            [present_3sg,     'becomes'],
            [present_1pl,     'become'],
            [progressive,     'becoming'],
            [past_simple,     'became'],
            [past_participle, 'become']
          ]
          test_inflection_of(lexm, expectations_1)
          
          lexm = subject.get_lexeme('do', WClasses::IrregularVerbDo)
          expectations_2 = [
            [present_1sg,     'do'],
            [present_3sg,     'does'],
            [present_1pl,     'do'],
            [progressive,     'doing'],
            [past_simple,     'did'],
            [past_participle, 'done']
          ]
          test_inflection_of(lexm, expectations_2)          
        end
      end # context
    end # describe
  end # module
end # module