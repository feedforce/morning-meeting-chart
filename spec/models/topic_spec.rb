require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'バリデーション' do
    it { should validate_presence_of(:content) }
  end
end
