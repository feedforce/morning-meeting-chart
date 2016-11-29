# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  entity     :integer          default("orders")
#  order      :integer
#

require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'validation' do
    describe '#name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_uniqueness_of(:name) }
    end

    describe '#order' do
      it { is_expected.to validate_presence_of(:order) }
      it { is_expected.to validate_uniqueness_of(:order) }

      it '1以上であること' do
        is_expected.to validate_numericality_of(:order)
                        .only_integer.is_greater_than_or_equal_to(1)
      end
    end

    describe '#entity' do
      it { is_expected.to validate_presence_of(:entity) }
    end
  end

  describe '#current_goal' do
    subject { team.current_goal }

    let(:team) { create(:team, name: 'hogeho', order: 100) }
    let!(:goal1) { create(:goal, team: team, date: Date.new(2016, 10)) }
    let!(:goal2) { create(:goal, team: team, date: Date.new(2016, 11)) }
    let!(:goal3) { create(:goal, team: team, date: Date.new(2016, 9)) }

    it '日付が最新の目標が返ること' do
      binding.pry
      expect(subject).to eq goal2
    end
  end
end
