class Progress < ApplicationRecord
  has_many :topics
  belongs_to :team

  validates :amount, presence: true
  validates :start_date, presence: true
end
