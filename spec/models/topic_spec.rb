# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  progress_id :integer
#  content     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Topic, type: :model do
  describe 'バリデーション' do
    it { should validate_presence_of(:content) }
  end
end
