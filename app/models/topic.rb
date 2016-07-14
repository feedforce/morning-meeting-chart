class Topic < ApplicationRecord
  belongs_to :progress

  validates :content, presence: true,
    unless: Proc.new { |topic| topic.content == '' }
end
