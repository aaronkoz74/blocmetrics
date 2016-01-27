class RegisteredApplication < ActiveRecord::Base
  belongs_to :user
  has_many :events

  before_validation :format_url_correctly

  # Check for uniqueness of url - multiple sites could have same name
  validates :url, uniqueness: true
  validates :url, format: { with: /http:\/\/.*/ }

  # Custom validation:
  # validate :url_format

  scope :ordered_by_name, -> { order('LOWER(name) ASC') }


  # def url_format
    # uri = URI.parse(self.url)
    # uri.kind_of?(URI::HTTP)
  # rescue URI::InvalidURIError
    # base[:errors] << 'invalid url'
  # end

  private

  def format_url_correctly
    unless self.url.downcase.include?("http://")
      self.url.prepend("http://")
    end
  end
end
