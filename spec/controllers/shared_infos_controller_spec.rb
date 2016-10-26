require 'rails_helper'

RSpec.describe SharedInfosController, type: :controller do
  describe 'GET #index' do
    subject { get :index }

    # NOTE: 2016年7月1日は、金曜日。4日は月曜日
    let!(:info1) { create(:shared_info, announce_date: Date.new(2016, 6, 1)) }
    let!(:info2) { create(:shared_info, announce_date: Date.new(2016, 7, 1)) }
    let!(:info3) { create(:shared_info, announce_date: Date.new(2016, 7, 4)) }

    context '今週分の共有情報が存在する時' do
      it '今週分のみを一覧で返すこと' do
        travel_to Date.new(2016, 7, 4) do
          subject
          expect(assigns(:shared_infos)).to eq [info2, info3]
        end
      end
    end

    context '今週分の共有情報が存在しない時' do
      it '空配列を返すこと' do
        travel_to Date.new(2017, 1, 1) do
          subject
          expect(assigns(:shared_infos)).to eq []
        end
      end
    end
  end
end
