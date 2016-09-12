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
  end
end
