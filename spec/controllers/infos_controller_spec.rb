require 'rails_helper'

RSpec.describe InfosController, type: :controller do
  let(:valid_attributes) {
    {
      title: 'test title 1',
      body: 'test body 1',
      owner: 'test owner 1',
      announce_date: '2016-08-08',
    }
  }

  let(:invalid_attributes) {
    {
      title: nil,
      body: nil,
      owner: nil,
      announce_date: nil,
    }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all infos as @infos" do
      info = Info.create! valid_attributes
      get :index, params: {}, session: valid_session
      expect(assigns(:infos)).to eq([info])
    end
  end

  describe "GET #show" do
    it "assigns the requested info as @info" do
      info = Info.create! valid_attributes
      get :show, params: {id: info.to_param}, session: valid_session
      expect(assigns(:info)).to eq(info)
    end
  end

  describe "GET #new" do
    it "assigns a new info as @info" do
      get :new, params: {}, session: valid_session
      expect(assigns(:info)).to be_a_new(Info)
    end
  end

  describe "GET #edit" do
    it "assigns the requested info as @info" do
      info = Info.create! valid_attributes
      get :edit, params: {id: info.to_param}, session: valid_session
      expect(assigns(:info)).to eq(info)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Info" do
        expect {
          post :create, params: {info: valid_attributes}, session: valid_session
        }.to change(Info, :count).by(1)
      end

      it "assigns a newly created info as @info" do
        post :create, params: {info: valid_attributes}, session: valid_session
        expect(assigns(:info)).to be_a(Info)
        expect(assigns(:info)).to be_persisted
      end

      it "redirects to the created info" do
        post :create, params: {info: valid_attributes}, session: valid_session
        expect(response).to redirect_to(Info.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved info as @info" do
        post :create, params: {info: invalid_attributes}, session: valid_session
        expect(assigns(:info)).to be_a_new(Info)
      end

      it "re-renders the 'new' template" do
        post :create, params: {info: invalid_attributes}, session: valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested info" do
        info = Info.create! valid_attributes
        put :update, params: {id: info.to_param, info: new_attributes}, session: valid_session
        info.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested info as @info" do
        info = Info.create! valid_attributes
        put :update, params: {id: info.to_param, info: valid_attributes}, session: valid_session
        expect(assigns(:info)).to eq(info)
      end

      it "redirects to the info" do
        info = Info.create! valid_attributes
        put :update, params: {id: info.to_param, info: valid_attributes}, session: valid_session
        expect(response).to redirect_to(info)
      end
    end

    context "with invalid params" do
      it "assigns the info as @info" do
        info = Info.create! valid_attributes
        put :update, params: {id: info.to_param, info: invalid_attributes}, session: valid_session
        expect(assigns(:info)).to eq(info)
      end

      it "re-renders the 'edit' template" do
        info = Info.create! valid_attributes
        put :update, params: {id: info.to_param, info: invalid_attributes}, session: valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested info" do
      info = Info.create! valid_attributes
      expect {
        delete :destroy, params: {id: info.to_param}, session: valid_session
      }.to change(Info, :count).by(-1)
    end

    it "redirects to the infos list" do
      info = Info.create! valid_attributes
      delete :destroy, params: {id: info.to_param}, session: valid_session
      expect(response).to redirect_to(infos_url)
    end
  end

end
