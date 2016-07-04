class Progress < ApplicationRecord
  has_many :topics
  belongs_to :team
end
