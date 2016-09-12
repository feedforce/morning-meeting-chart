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
  end
end
