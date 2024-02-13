class LinkShortnerController < ApplicationController
  def create
    text = link_shortner_params
    shortened_url = Url.shorten(text)
    url = Url.new(original: text, shortened: shortened_url)
    if url.save
      render plain: shortened_url
    else
      render plain: 'Please use a valid url'
    end
  end

  private

  def link_shortner_params
    params.fetch('text')
  end
end
