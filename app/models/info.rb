class Info < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :announce_date, presence: true
end
