# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  date       :date
#  goal       :integer
#  team_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Goal, type: :model do
  describe 'validation' do
    describe '#date' do
      it { is_expected.to validate_presence_of(:date) }
    end

    describe '#goal' do
      it { is_expected.to validate_presence_of(:goal) }
      it '値が1以上であること' do
        is_expected.to validate_numericality_of(:goal)
                        .only_integer.is_greater_than_or_equal_to(1)
      end
    end
  end
end
