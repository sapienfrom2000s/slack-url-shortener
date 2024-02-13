require 'rails_helper'

RSpec.describe Url do
  describe '#shorten' do
    let!(:shortened_url_regex) { %r{^(https://customdomain)/([a-zA-Z0-9_]){5}$} }
    let!(:url) { 'https://www.youtube.com/watch?v=SJovyCWgiZs' }

    it 'must return a shortened url' do
      shortened_url = described_class.shorten(url)
      expect(shortened_url).to match(shortened_url_regex)
    end

    context 'when generated shortened url is present in database' do
      let!(:alphanumeric_code) { 'uiui9' }
      let!(:shortened_url) { "http://customdomain.com/#{alphanumeric_code}" }

      before do
        described_class.create(original: 'http://dummy.com', shortened: shortened_url)
        allow(described_class).to receive(:generate_alphanumeric_code)
          .and_return(alphanumeric_code, described_class.generate_alphanumeric_code)
      end

      it 'must regenerate a new shortened url' do
        expect(described_class.shorten(url)).not_to eq(shortened_url)
      end
    end
  end

  describe '#generate_alphanumeric_code' do
    let!(:alphanumeric_regex_5) { /^([a-zA-Z0-9_]){5}$/ }

    it 'generates 5 digit alphanumeric code by default' do
      expect(described_class.generate_alphanumeric_code).to match(alphanumeric_regex_5)
    end
  end

  describe '#valid?' do
    it 'must return true if url is passed' do
      good_url = 'https://lichess.org'
      expect(described_class.valid?(good_url)).to be true
    end

    it 'must return false if url is not passed' do
      bad_url = 'a normal string'
      expect(described_class.valid?(bad_url)).to be false
    end
  end
end
