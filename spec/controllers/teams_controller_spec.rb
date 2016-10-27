require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  describe 'GET #show' do
    subject { get :show, params: { id: team.id } }
    let(:team) { create(:team) }

    context '正常系' do
      let(:goal1) { create(:goal, team: team, date: Date.new(2016, 7, 1)) }
      let!(:goal2) { create(:goal, team: team, date: Date.new(2016, 6, 1)) }
      let(:progress1) do
        create(
          :progress,
          goal: goal1,
          start_date: Date.new(2016, 7, 4)
        )
      end
      let(:progress2) do
        create(
          :progress,
          goal: goal1,
          start_date: Date.new(2016, 7, 11)
        )
      end
      let!(:topic1) { create(:topic, progress: progress1, content: 'test1') }
      let!(:topic2) { create(:topic, progress: progress2, content: 'test2') }

      it '1番新しい Date の Goal のグラフを使うこと' do
        subject
        expect(assigns(:goal)).to eq goal1
      end

      it '1番新しい Progress の Topic を使うこと' do
        subject
        expect(assigns(:topic)).to eq topic2
      end

      context '前回の朝礼以降に登録された共有情報がある時' do
        let!(:info) { create(:shared_info, announce_date: date)}
        let(:date) { Time.new(2016, 7, 11) }
        it 'その共有情報に登録されたものを返す' do
          travel_to date do
            subject
            expect(assigns(:info)).to eq info
          end
        end
      end

      context '前回の朝礼以降に登録された共有情報がない時' do
        let!(:info) do
          create(:shared_info, announce_date: Date.new(2016, 6, 1))
        end
        it 'その共有情報を返す' do
          travel_to Time.new(2016, 7, 11) do
            subject
            expect(assigns(:info)).to eq nil
          end
        end
      end
    end

    context '異常系' do
      context 'Goal がない状態で、グラフを表示しようとした時' do
        before { subject }

        it 'トップページへリダイレクトすること' do
          expect(response).to redirect_to teams_path
        end

        it 'エラーメッセージがセットされていること' do
          expect(flash[:alert]).to eq('目標や進捗を登録してからグラフを作成してください。')
        end
      end
    end
  end
end
