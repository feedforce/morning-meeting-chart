# == Schema Information
#
# Table name: progresses
#
#  id         :integer          not null, primary key
#  start_date :date
#  amount     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  end_date   :date
#  goal_id    :integer
#

class Progress < ApplicationRecord
  has_one :topic, dependent: :destroy
  belongs_to :goal

  validates :start_date, presence: true
  validates :amount, presence: true

  scope :latest, -> { order(:start_date).last }

  def amount_formatted
    if self.amount < 1000
      ActionController::Base.helpers.number_to_currency(
        self.amount,
        format: "%n%u",
        unit: ' 件',
        precision: 0
      )
    else
      ActionController::Base.helpers.number_to_currency(
        self.amount,
        format: "%n%u",
        unit: ' 円',
        precision: 0
      )
    end
  end

  private

  def set_default
    self.start_date ||= last_monday
  end

  def last_monday
    this_day = Date.today
    (this_day - (this_day.wday - 1)) - 7
  end
end
