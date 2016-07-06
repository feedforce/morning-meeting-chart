require 'rails_helper'

RSpec.describe Progress, type: :model do
  describe 'リレーション' do
    it { should belong_to(:team) }
  end

  describe 'バリデーション' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:amount) }
  end
end
