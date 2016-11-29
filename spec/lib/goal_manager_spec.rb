require 'rails_helper'

RSpec.describe GoalManager, type: :lib do
  describe '#create_next_week' do
    subject { GoalManager.create_next_week }

    let(:team1) { create(:team) }
    let(:team2) { create(:team) }

    let(:today) { Date.new(2016, 11, 21) }

    around do |example|
      travel_to today do
        example.run
      end
    end

    context '次の営業開始日が同月の場合' do
      let!(:goal1) { create(:goal, team: team1, date: Date.new(2016,11)) }

      context '今月の目標が存在する場合' do
        it '新しい目標を作成しない' do
          expect{ subject }.not_to change(team1.reload.goals, :count)
        end

        context '今週の進捗が存在する場合' do
          let!(:progress) { create(:progress, goal: goal1, start_date: today) }

          it '来週の進捗を作成する' do
            subject
            expect(goal1.reload.progresses.count).to eq 2
            expect(goal1.reload.progresses.last.start_date).to eq today + 1.week
          end
        end

        context '今週の進捗が存在しない場合' do
          it '来週の進捗を作成する' do
            subject
            expect(goal1.reload.progresses.count).to eq 1
            expect(goal1.reload.progresses.last.start_date).to eq today + 1.week
          end
        end
      end

      context '今月の目標が存在しない場合' do
        it '今月の目標を作成する' do
          subject
          expect(team1.reload.goals.count).to eq 1
          expect(team1.reload.goals.last.date).to eq Date.new(2016, 11, 1)
        end

        it '来週の進捗を作成する' do
          subject
          expect(team1.reload.goals.last.progresses.count).to eq 1
          expect(team1.reload.goals.last.progresses.last.start_date).to eq today + 1.week
        end
      end
    end
  end
end
