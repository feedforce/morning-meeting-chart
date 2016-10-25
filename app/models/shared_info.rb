# == Schema Information
#
# Table name: shared_infos
#
#  id            :integer          not null, primary key
#  title         :string
#  owner         :string
#  body          :string
#  announce_date :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class SharedInfo < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :announce_date, presence: true

  scope :this_period, -> do
    where('? < announce_date AND announce_date <= ?', Date.today - 7, Date.today).order(:id)
  end

  def previous
    SharedInfo.where('id < ?', self.id).order(:id).last
  end

  def next
    SharedInfo.where('id < ?', self.id).order(:id).first
  end

  def self.has_prev_info?(id)
    exists?(['? < announce_date AND announce_date <= ? AND "id" < ?', Date.today - 7, Date.today, id])
  end

  def self.has_next_info?(id)
    exists?(['? < announce_date AND announce_date <= ? AND "id" > ?', Date.today - 7, Date.today, id])
  end
end
