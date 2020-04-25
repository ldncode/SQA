class Question < ApplicationRecord
  validates :title, :body, presence: true
end
