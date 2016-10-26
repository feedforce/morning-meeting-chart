require 'rails_helper'

RSpec.describe SharedInfosController, type: :controller do
  let(:valid_attributes) {
    {
      title: 'test title 1',
      body: 'test body 1',
      owner: 'test owner 1',
      announce_date: '2016-08-08',
    }
  }
  describe 'GET #index' do
    subject { get :index }

  let(:invalid_attributes) {
    {
      title: nil,
      body: nil,
      owner: nil,
      announce_date: nil,
    }
  }
    # NOTE: 2016年7月1日は、金曜日。4日は月曜日
    let!(:info1) { create(:shared_info, announce_date: Date.new(2016, 6, 1)) }
    let!(:info2) { create(:shared_info, announce_date: Date.new(2016, 7, 1)) }
    let!(:info3) { create(:shared_info, announce_date: Date.new(2016, 7, 4)) }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all shared_infos as @shared_infos" do
      shared_info = SharedInfo.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:shared_infos)).to eq([shared_info])
    end
  end

  describe "GET #show" do
    it "assigns the requested shared_info as @shared_info" do
      shared_info = SharedInfo.create! valid_attributes
      get :show, params: {id: shared_info.to_param}, session: valid_session
      expect(assigns(:shared_info)).to eq(shared_info)
    end
  end

  describe "GET #new" do
    it "assigns a new shared_info as @shared_info" do
      get :new, params: {}, session: valid_session
      expect(assigns(:shared_info)).to be_a_new(SharedInfo)
    end
  end

  describe "GET #edit" do
    it "assigns the requested shared_info as @shared_info" do
      shared_info = SharedInfo.create! valid_attributes
      get :edit, params: {id: shared_info.to_param}, session: valid_session
      expect(assigns(:shared_info)).to eq(shared_info)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new SharedInfo" do
        expect {
          post :create, params: {shared_info: valid_attributes}, session: valid_session
        }.to change(SharedInfo, :count).by(1)
      end

      it "assigns a newly created shared_info as @shared_info" do
        post :create, params: {shared_info: valid_attributes}, session: valid_session
        expect(assigns(:shared_info)).to be_a(SharedInfo)
        expect(assigns(:shared_info)).to be_persisted
      end

      it "redirects to the created shared_info" do
        post :create, params: {shared_info: valid_attributes}, session: valid_session
        expect(response).to redirect_to(SharedInfo.last)
    context '今週分の共有情報が存在する時' do
      it '今週分のみを一覧で返すこと' do
        travel_to Date.new(2016, 7, 4) do
          subject
          expect(assigns(:shared_infos)).to eq [info2, info3]
        end
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved shared_info as @shared_info" do
        post :create, params: {shared_info: invalid_attributes}, session: valid_session
        expect(assigns(:shared_info)).to be_a_new(SharedInfo)
      end

      it "re-renders the 'new' template" do
        post :create, params: {shared_info: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested shared_info" do
        shared_info = SharedInfo.create! valid_attributes
        put :update, params: {id: shared_info.to_param, shared_info: new_attributes}, session: valid_session
        shared_info.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested shared_info as @shared_info" do
        shared_info = SharedInfo.create! valid_attributes
        put :update, params: {id: shared_info.to_param, shared_info: valid_attributes}, session: valid_session
        expect(assigns(:shared_info)).to eq(shared_info)
      end

      it "redirects to the shared_info" do
        shared_info = SharedInfo.create! valid_attributes
        put :update, params: {id: shared_info.to_param, shared_info: valid_attributes}, session: valid_session
        expect(response).to redirect_to(shared_info)
      end
    end

    context "with invalid params" do
      it "assigns the shared_info as @shared_info" do
        shared_info = SharedInfo.create! valid_attributes
        put :update, params: {id: shared_info.to_param, shared_info: invalid_attributes}, session: valid_session
        expect(assigns(:shared_info)).to eq(shared_info)
      end

      it "re-renders the 'edit' template" do
        shared_info = SharedInfo.create! valid_attributes
        put :update, params: {id: shared_info.to_param, shared_info: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
    context '今週分の共有情報が存在しない時' do
      it '空配列を返すこと' do
        travel_to Date.new(2017, 1, 1) do
          subject
          expect(assigns(:shared_infos)).to eq []
        end
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested shared_info" do
      shared_info = SharedInfo.create! valid_attributes
      expect {
        delete :destroy, params: {id: shared_info.to_param}, session: valid_session
      }.to change(SharedInfo, :count).by(-1)
    end

    it "redirects to the shared_infos list" do
      shared_info = SharedInfo.create! valid_attributes
      delete :destroy, params: {id: shared_info.to_param}, session: valid_session
      expect(response).to redirect_to(shared_infos_url)
    end
  end

end
