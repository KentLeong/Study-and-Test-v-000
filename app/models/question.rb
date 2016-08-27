class Question < ActiveRecord::Base
  belongs_to :study
  belongs_to :test
end
