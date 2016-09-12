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

require 'rails_helper'

RSpec.describe Progress, type: :model do
  describe 'validation' do
    describe '#start_date' do
      it { is_expected.to validate_presence_of(:start_date) }
    end

    describe '#amount' do
      it { is_expected.to validate_presence_of(:amount) }
      it '0以上であること' do
        is_expected.to validate_numericality_of(:amount)
                        .only_integer.is_greater_than_or_equal_to(0)
      end
    end
  end
end
