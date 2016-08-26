class SharedInfo < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :announce_date, presence: true

  scope :this_period, -> {
    where('? < announce_date AND announce_date <= ?', Date.today - 7, Date.today)
  }

  scope :prev_id, -> (id) {
    where('id < ?', id).order(:id).last
  }

  scope :next_id, -> (id) {
    where('id > ?', id).order(:id).first
  }

  def self.has_prev_info?(id)
    exists?(['? < announce_date AND announce_date <= ? AND "id" < ?', Date.today - 7, Date.today, id])
  end

  def self.has_next_info?(id)
    exists?(['? < announce_date AND announce_date <= ? AND "id" > ?', Date.today - 7, Date.today, id])
  end
end
