# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  progress_id :integer
#  content     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Topic < ApplicationRecord
  belongs_to :progress

  validates :content, presence: true,
    unless: Proc.new { |topic| topic.content == '' }
end
