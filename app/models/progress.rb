class Progress < ApplicationRecord
  belongs_to :team
  after_initialize :set_default, if: :new_record?

  validates :start_date, presence: true
  validates :amount, presence: true

  private
  def set_default
    self.start_date ||= last_monday
  end

  def last_monday
    this_day = Date.today
    (this_day - (this_day.wday - 1)) - 7
  end

end
