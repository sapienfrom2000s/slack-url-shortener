require 'rails_helper'

RSpec.describe 'Link Shortner', type: :request do
  let(:shortened_url_regex) { %r{^(https://customdomain)/([a-zA-Z0-9_]){5}$} }
  let(:good_url) { 'https://www.youtube.com/watch?v=SJovyCWgiZs' }
  let(:bad_url) { 'a normal string' }

  it "responds with shortened url if params['text'] contains a url" do
    post '/link_shortner/create', params: { 'text' => good_url }
    expect(response.body).to match shortened_url_regex
  end

  it "resonds with a friendly error if params['text'] does not contain url" do
    post '/link_shortner/create', params: { 'text' => bad_url }
    expect(response.body).to include('Please use a valid url')
  end
end
