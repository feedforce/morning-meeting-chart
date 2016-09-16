# == Schema Information
#
# Table name: shared_infos
#
#  id            :integer          not null, primary key
#  title         :string
#  owner         :string
#  body          :string
#  announce_date :date
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe SharedInfo, type: :model do
  describe 'validation' do
    describe '#title' do
      it { is_expected.to validate_presence_of(:title) }
    end

    describe '#body' do
      it { is_expected.to validate_presence_of(:body) }
    end

    describe '#announce_date' do
      it { is_expected.to validate_presence_of(:announce_date) }
    end
  end
end
