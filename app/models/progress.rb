class Progress < ApplicationRecord
  belongs_to :team

  validates :start_date, presence: true
  validates :amount, presence: true
end
