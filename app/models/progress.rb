class Progress < ApplicationRecord
  # after_initialize :set_default, if: :new_record?

  belongs_to :team
  has_many :topics

  validates :start_date, presence: true
  validates :amount, presence: true

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
