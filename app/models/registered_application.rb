class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  has_many :events

  validates_uniqueness_of :name, :url

  default_scope { order ('name ASC') }
end
