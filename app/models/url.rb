require 'faraday'
require 'securerandom'

class Url < ApplicationRecord
  validates :shortened, presence: true
  validates :original, presence: true

  DOMAIN = 'customdomain.com'.freeze

  def self.generate_alphanumeric_code(length = 5)
    SecureRandom.alphanumeric(length)
  end

  def self.valid?(url)
    Faraday.get(url).success?
  rescue StandardError
    false
  end

  def self.shorten(url)
    return nil unless valid?(url)

    loop do
      shortened_link = "https://#{DOMAIN}/#{generate_alphanumeric_code}"
      return shortened_link unless Url.exists?(shortened: shortened_link)
    end
  end
end
