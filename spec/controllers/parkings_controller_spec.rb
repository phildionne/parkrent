require 'spec_helper'

describe ParkingsController do
  # @FIXME Consider adding context to test a signed in/signed out usecase
  let(:user) { create(:user) }
  before do
    user.confirm!
    sign_in user
  end

  describe "GET index" do
    before { get :index }

    it "responds with success and render template" do
      expect(response).to be_success
      expect(response).to render_template :index
    end
  end

  describe "GET show" do
    let(:parking) { create(:parking) }

    before { get :show, id: parking }

    it "assigns the parking as @parking" do
      expect(assigns(:parking)).to eq(parking)
    end

    it "responds with success and render template" do
      expect(response).to be_success
      expect(response).to render_template :show
    end
  end

  describe "GET new" do
    before { get :new }

    it "assigns a new parking as @parking" do
      expect(assigns(:parking)).to be_a_new(Parking)
    end

    it "responds with success and render template" do
      expect(response).to be_success
      expect(response).to render_template :new
    end
  end

  describe "GET edit" do
    let(:parking) { create(:parking, user: user) }

    before { get :edit, id: parking }

    it "assigns the requested parking to @parking" do
      expect(assigns(:parking)).to eq(parking)
    end

    it "responds with success and render template" do
      expect(response).to be_success
      expect(response).to render_template :edit
    end
  end

  describe "POST create" do
    context "with valid params" do
      let(:parking_attributes) { attributes_for(:parking) }

      it "creates a new Parking" do
        expect {
          post :create, { parking: parking_attributes }
        }.to change(Parking, :count).by(1)
      end

      it "assigns a newly created parking as @parking" do
        post :create, { parking: parking_attributes }
        expect(assigns(:parking)).to be_a(Parking)
        expect(assigns(:parking)).to be_persisted
      end

      it "redirects to the created parking" do
        post :create, { parking: parking_attributes }
        expect(response).to redirect_to(assigns(:parking))
      end
    end

    context "with invalid params" do
      before { post :create, parking: attributes_for(:invalid_parking) }

      it "assigns a newly created but unsaved parking as @parking" do
        expect(assigns(:parking)).to be_a_new(Parking)
        expect(assigns(:parking)).not_to be_persisted
      end

      it { should render_template :new }
    end
  end

  describe "PATCH update" do
    let(:parking) { create(:parking, location: "Somewhere", user: user) }

    context "with valid params" do
      it "assigns the requested parking as @parking" do
        patch :update, { id: parking, parking: attributes_for(:parking)}
        expect(assigns(:parking)).to eq(parking)
      end

      it "updates the requested parking" do
        patch :update, { id: parking, parking: attributes_for(:parking, location: "Somewhere else") }
        parking.reload
        expect(parking.location).to eq("Somewhere else")
      end

      it "redirects to the parking" do
        patch :update, { id: parking, parking: attributes_for(:parking) }
        parking.reload
        expect(response).to redirect_to(parking)
      end
    end

    context "with invalid params" do
      it "assigns the parking as @parking" do
        patch :update, { id: parking, parking: attributes_for(:invalid_parking) }
        expect(assigns(:parking)).to eq(parking)
      end

      it "does not update @parking's attributes" do
        patch :update, { id: parking, parking: attributes_for(:invalid_parking, location: " ") }
        parking.reload
        expect(parking.location).to_not eq(" ")
      end

      it "re-renders the 'edit' template" do
        patch :update, { id: parking, parking: attributes_for(:invalid_parking) }
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    let!(:parking) { create(:parking, user: user) }

    it "destroys the requested parking" do
      expect {
        delete :destroy, { id: parking }
      }.to change(Parking, :count).by(-1)
    end

    it "redirects to the dashboard" do
      delete :destroy, { id: parking }
      expect(response).to redirect_to(root_path)
    end
  end
end
