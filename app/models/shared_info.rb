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

  # TODO: 7日前となっているけど、実際には前回の朝会の日から次の朝会の日までという実装になるはず
  scope :this_period, -> do
    where('? < announce_date AND announce_date <= ?', Date.today - 7, Date.today).order(:id)
  end

  def previous
    SharedInfo.this_period.where('id < ?', self.id).order(:id).last
  end

  def next
    SharedInfo.this_period.where('id > ?', self.id).order(:id).first
  end
end
