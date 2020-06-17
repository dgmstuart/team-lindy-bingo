# frozen_string_literal: true

require 'lib/word_list'

RSpec.describe WordList do
  describe '#to_url' do
    it 'creates a url for a bingo card' do
      word_list = described_class.new('word')

      expect(word_list.to_url).to eq 'https://osric.com/bingo-card-generator?onlyCard=true&title=Team+Lindy+Bingo&words=word'
    end

    it 'strips extra whitespace' do
      word_list = described_class.new('word, mot')

      expect(word_list.to_url).to eq 'https://osric.com/bingo-card-generator?onlyCard=true&title=Team+Lindy+Bingo&words=word,mot'
    end

    it 'strips newlines' do
      word_list = described_class.new("word,\nmot")

      expect(word_list.to_url).to eq 'https://osric.com/bingo-card-generator?onlyCard=true&title=Team+Lindy+Bingo&words=word,mot'
    end

    it 'simplifies quote marks' do
      word_list = described_class.new('Duck ’n’ dive')

      expect(word_list.to_url).to eq 'https://osric.com/bingo-card-generator?onlyCard=true&title=Team+Lindy+Bingo&words=Duck+%27n%27+dive'
    end
  end
end
