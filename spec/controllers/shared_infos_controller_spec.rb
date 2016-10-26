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

  describe 'GET #show' do
    subject { get :show, params: { id: info.id } }

    context '今週分の共有情報がある場合' do
      context '１つの場合' do
        let!(:past_info) { create(:shared_info, announce_date: Date.new(2016, 6, 1)) }
        let!(:future_info) { create(:shared_info, announce_date: Date.new(2016, 8, 1)) }
        let!(:info) { create(:shared_info, announce_date: Date.new(2016, 7, 4)) }

        it '@shared_info に共有情報が入っていること' do
          travel_to Date.new(2016, 7, 4) do
            subject
            expect(assigns(:shared_info)).to eq info
          end
        end

        it '@previous_info が nil であること' do
          travel_to Date.new(2016, 7, 4) do
            subject
            expect(assigns(:previous_info)).to eq nil
          end
        end

        it '@next_info が nil であること' do
          travel_to Date.new(2016, 7, 4) do
            subject
            expect(assigns(:next_info)).to eq nil
          end
        end
      end

      context '複数の場合' do
        context 'id の小さいものがある場合' do
          let!(:previous_info) { create(:shared_info, announce_date: Date.new(2016, 7, 4)) }
          let!(:info) { create(:shared_info, announce_date: Date.new(2016, 7, 4)) }

          it '@shared_info に共有情報が入っていること' do
            travel_to Date.new(2016, 7, 4) do
              subject
              expect(assigns(:shared_info)).to eq info
            end
          end

          it '@previous_info に共有情報が入っていること' do
            travel_to Date.new(2016, 7, 4) do
              subject
              expect(assigns(:previous_info)).to eq previous_info
            end
          end

          it '@next_info が nil であること' do
            travel_to Date.new(2016, 7, 4) do
              subject
              expect(assigns(:next_info)).to eq nil
            end
          end
        end

        context 'id の大きいものがある場合' do
          let!(:info) { create(:shared_info, announce_date: Date.new(2016, 7, 4)) }
          let!(:next_info) { create(:shared_info, announce_date: Date.new(2016, 7, 4)) }
          it '@shared_info に共有情報が入っていること' do
            travel_to Date.new(2016, 7, 4) do
              subject
              expect(assigns(:shared_info)).to eq info
            end
          end

          it '@previous_info が nil であること' do
            travel_to Date.new(2016, 7, 4) do
              subject
              expect(assigns(:previous_info)).to eq nil
            end
          end

          it '@next_info に共有情報がはいっていること' do
            travel_to Date.new(2016, 7, 4) do
              subject
              expect(assigns(:next_info)).to eq next_info
            end
          end
        end
      end
    end
  end
end
