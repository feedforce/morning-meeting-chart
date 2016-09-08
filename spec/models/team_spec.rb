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
  describe 'バリデーション' do
    it { should validate_presence_of(:name) }
  end
end
