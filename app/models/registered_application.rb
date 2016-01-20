class RegisteredApplication < ActiveRecord::Base
  belongs_to :user

  validates_uniqueness_of :name, :url

  default_scope { order ('name ASC') }
end
