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
  end
end
