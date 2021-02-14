class User < ApplicationRecord
  require 'net/http'
  require 'uri'

  validate :image_exists
  validates :name, presence: true
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  def image_exists
    url = URI.parse(self.photo_url)
    http = Net::HTTP.start(url.host, url.port, :use_ssl => url.scheme == 'https')

    if !http.head(url.request_uri)['Content-Type'].start_with? 'image'
      errors.add(:photo_url, "Url given is not an image")
    end
  end
end
