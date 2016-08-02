class Goal < ApplicationRecord
  has_many :progresses, dependent: :destroy
  belongs_to :team
end
