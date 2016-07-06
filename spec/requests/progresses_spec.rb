require 'rails_helper'

RSpec.describe "Progresses", type: :request do
  describe 'GET /teams/:team_id/progress' do
    subject { get "/teams/#{team.id}/progresses" }
    let(:team) { create(:team) }
    it_behaves_like 'HTTP 200 OK'
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
          amount: 3
        },
        topic: {
          content: 'test content'
        }
      }
    end

    describe '正常系' do
      it_behaves_like 'HTTP 302 Found'
      it_behaves_like 'redirect' do
        let(:redirect_path) { root_path }
      end

      it 'Progress が 1 つ作られる' do
        expect { subject }.to change(Progress, :count).by(1)
      end

      it 'Topic が 1 つ作られる' do
        expect { subject }.to change(Topic, :count).by(1)
      end
    end
  end
end
