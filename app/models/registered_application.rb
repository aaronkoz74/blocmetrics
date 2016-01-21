class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  has_many :events

  validates_uniqueness_of :name, :url

  scope :ordered_by_name, -> { order('name ASC') }
end

# RegisteredApplication.ordered_by_name
