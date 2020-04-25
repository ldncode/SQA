class Question < ApplicationRecord
  has_many :answers

  validates :title, :body, presence: true
end
