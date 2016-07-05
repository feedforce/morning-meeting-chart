require 'rails_helper'

RSpec.describe Progress, type: :model do
  describe 'リレーション' do
    it { should belong_to(:team) }
  end
end
