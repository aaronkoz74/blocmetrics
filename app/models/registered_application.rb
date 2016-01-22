class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  has_many :events

  validates_uniqueness_of :name, :url
  require 'uri'


  scope :ordered_by_name, -> { order('LOWER(name) ASC') }

  def valid?(url)
    uri = URI.parse(url)
    uri.kind_of?(URI::HTTP)
  rescue URI::InvalidURIError
    false
  end
end
