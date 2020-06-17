# frozen_string_literal: true

require 'uri'
require 'active_support/core_ext/object/to_query'

# Takes a list of words, optimises it for length and makes a bingo card url
class WordList
  def initialize(raw_word_list)
    @raw_word_list = raw_word_list
  end

  def to_url
    url
      .gsub('%2C', ',') # We don't need to encode commas
  end

  private

  attr_reader :raw_word_list

  def url
    URI::HTTPS.build(
      host: 'osric.com',
      path: '/bingo-card-generator',
      query: {
        title: 'Team Lindy Bingo',
        words: normalised_word_list,
        onlyCard: 'true'
      }.to_query
    ).to_s
  end

  def normalised_word_list
    raw_word_list
      .split(',')
      .map(&:strip)
      .join(',')
  end
end
