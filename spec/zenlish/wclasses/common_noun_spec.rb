# frozen_string_literal: true

require_relative '../../spec_helper' # Use the RSpec framework
require_relative '../../../lib/zenlish/lang/dictionary'
require_relative '../../../lib/zenlish/wclasses/common_noun' # Load the class under test

module Zenlish
  module WClasses
    describe CommonNoun do
      subject { CommonNoun.new }

      context 'Initialization:' do
        it 'should be initialized without argument' do
          expect { CommonNoun.new }.not_to raise_error
        end
      end # context

      context 'Provided services:' do
        it 'should provide a default inflection paradigm' do
          expect(subject.paradigm).not_to be_nil
        end

        it 'should support the pluralization of common nouns' do
          lexemes = []
          Lang::Dictionary.entries.each do |ent|
            lexm = ent.lexemes.select { |lx| lx.wclass.kind_of?(Zenlish::WClasses::CommonNoun) }
            lexemes.concat(lexm) if lexm
          end
          samples = %w[ animal body people]
          plural_sample = { 'animal' => 'animals',
            'body' => 'bodies',
            'people' => 'people'}
          selection = lexemes.select { |lx| samples.include?(lx.entry.lemma) }

          selection.map do |lx|
            pluralized = lx.inflect([:plural, nil])
            expect(pluralized).to eq(plural_sample[lx.base_form])
          end
        end
      end # context
    end # describe
  end # module
end # module