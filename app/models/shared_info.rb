class SharedInfo < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true
  validates :announce_date, presence: true

  scope :prev_info, -> (announce_date, id) {
    where('"announce_date" = ? AND "id" < ?', announce_date, id).order(:id).last
  }
  scope :next_info, -> (announce_date, id) {
    where('"announce_date" = ? AND "id" > ?', announce_date, id).order(:id).first
  }

  def self.has_prev_info?(announce_date, id)
    exists?(['"announce_date" = ? AND "id" < ?', announce_date, id])
  end

  def self.has_next_info?(announce_date, id)
    exists?(['"announce_date" = ? AND "id" > ?', announce_date, id])
  end
end
