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
end
