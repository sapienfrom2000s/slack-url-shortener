require 'uri'
require 'securerandom'

class Url < ApplicationRecord
  validates :shortened, presence: true
  validates :original, presence: true

  DOMAIN = 'customdomain'.freeze

  def self.generate_alphanumeric_code(length = 5)
    SecureRandom.alphanumeric(length)
  end

  def self.valid?(url)
    url = URI.parse(url)
    url.kind_of? URI::HTTP
    rescue URI::InvalidURIError
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
