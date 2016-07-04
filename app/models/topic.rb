class Topic < ApplicationRecord
  belongs_to :progress
  validates :content, present: true
end
