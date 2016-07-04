class Topic < ApplicationRecord
  belongs_to :progress
  validates :content, presence: true
end
