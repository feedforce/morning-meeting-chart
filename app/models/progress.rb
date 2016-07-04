class Progress < ApplicationRecord
  has_many :topics
  belongs_to :team

  validates :amount, present: true
  validates :start_date, present: true
end
