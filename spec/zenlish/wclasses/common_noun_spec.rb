# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lang/dictionary'
require_relative '../../../lib/zenlish/wclasses/common_noun' # Load the class under test

module Zenlish
  module WClasses
    describe CommonNoun do
      subject(:noun) { described_class.new }

      context 'Initialization:' do
        it 'is initialized without argument' do
          expect { described_class.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'provides a default inflection paradigm' do
          expect(noun.paradigm).not_to be_nil
        end

        it 'supports the pluralization of common nouns' do
          samples = %w[animal body people]
          lexemes = []
          Lang::Dictionary.entries.each do |ent|
            lexm = ent.lexemes.select { |lx| lx.wclass.kind_of?(described_class) }
            if lexm && samples.include?(ent.lemma)
              lexemes.concat(lexm)
            end
          end
          plural_sample = { 'animal' => 'animals',
            'body' => 'bodies',
            'people' => 'people' }
          lexemes.map do |lx|
            pluralized = lx.inflect([:plural, nil])
            expect(pluralized).to eq(plural_sample[lx.base_form])
          end
        end

        it 'knows all its inflections' do
          samples = %w[animal body people]
          lexemes = []
          Lang::Dictionary.entries.each do |ent|
            lexm = ent.lexemes.select { |lx| lx.wclass.kind_of?(described_class) }
            if lexm && samples.include?(ent.lemma)
              lexemes.concat(lexm)
            end
          end
          lexemes.map(&:all_inflections)
        end
      end # context
    end # describe
  end # module
end # module
