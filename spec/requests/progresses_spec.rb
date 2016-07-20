require 'rails_helper'

RSpec.xdescribe "Progresses", type: :request do
  describe 'GET /teams/:team_id/progress' do
    subject { get "/teams/#{team.id}/progresses" }
    let(:team) { create(:team) }
    it_behaves_like 'HTTP 200 OK'
  end

  describe 'GET /teams/:team_id/progresses/new' do
    subject { get "/teams/#{team.id}/progresses/new" }
    let(:team) { create(:team) }
    it_behaves_like 'HTTP 200 OK'
    it_behaves_like 'render template' do
      let(:template) { 'new' }
    end
  end

  describe 'POST /teams/:team_id/progress' do
    subject { post "/teams/#{team.id}/progresses", params }
    let(:team) { create(:team) }
    let(:params) do
      {
        team: {
          goal: 10
        },
        progress: {
          amount: 3,
          start_date: Date.current
        },
        topic: {
          content: {
            '1' => 'test content',
            '2' => 'test content 2',
            '3' => '',
          },
        },
      }
    end

    describe '正常系' do
      it_behaves_like 'HTTP 302 Found'
      it_behaves_like 'redirect' do
        let(:redirect_path) { team_progresses_path(team) }
      end

      it 'Progress が 1 つ作られる' do
        expect { subject }.to change(Progress, :count).by(1)
      end

      it 'Topic が 3 つ作られる' do
        expect { subject }.to change(Topic, :count).by(3)
      end
    end
  end
end
