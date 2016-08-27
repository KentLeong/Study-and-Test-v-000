class Study < ActiveRecord::Base
  belongs_to :tests
  has_many :multiple_choices
end
