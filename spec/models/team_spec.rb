require 'rails_helper'

RSpec.describe Team, type: :model do
  describe 'バリデーション' do
    it { should validate_presence_of(:name) }
  end
end
