require 'spec_helper'

describe ParkingsController do
  # @FIXME Consider adding context to test a signed in/signed out usecase
  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "GET index" do
    before { get :index }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :index
    end
  end

  describe "GET show" do
    let(:parking) { FactoryGirl.create(:parking) }

    before { get :show, id: parking }

    it "assigns the parking as @parking" do
      assigns(:parking).should eq(parking)
    end

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :show
    end
  end

  describe "GET new" do
    before { get :new }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :new
    end
  end

  describe "GET edit" do
    let(:parking) { FactoryGirl.create(:parking, user: user) }

    before { get :edit, id: parking }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :edit
    end
  end

  describe "POST create" do
    context "with valid params" do
      let(:parking_attributes) { FactoryGirl.attributes_for(:parking) }

      it "creates a new Parking" do
        expect {
          post :create, { parking: parking_attributes }
        }.to change(Parking, :count).by(1)
      end

      it "assigns a newly created parking as @parking" do
        post :create, { parking: parking_attributes }
        assigns(:parking).should be_a(Parking)
        assigns(:parking).should be_persisted
      end

      it "redirects to the created parking" do
        post :create, { parking: parking_attributes }
        response.should redirect_to(Parking.last)
      end
    end

    context "with invalid params" do
      before { post :create, parking: FactoryGirl.attributes_for(:invalid_parking) }

      it "assigns a newly created but unsaved parking as @parking" do
        assigns(:parking).should be_a_new(Parking)
      end

      it { should render_template :new }
    end
  end

  describe "PUT update" do
    let(:parking) { FactoryGirl.create(:parking, location: "Somewhere", user: user) }

    context "with valid params" do
      it "assigns the requested parking as @parking" do
        put :update, { id: parking, parking: FactoryGirl.attributes_for(:parking)}
        assigns(:parking).should eq(parking)
      end

      it "updates the requested parking" do
        put :update, { id: parking, parking: FactoryGirl.attributes_for(:parking, location: "Somewhere else") }
        parking.reload
        parking.location.should eq("Somewhere else")
      end

      it "redirects to the parking" do
        put :update, { id: parking, parking: FactoryGirl.attributes_for(:parking) }
        parking.reload
        response.should redirect_to(parking)
      end
    end

    context "with invalid params" do
      it "assigns the parking as @parking" do
        put :update, { id: parking, parking: FactoryGirl.attributes_for(:invalid_parking) }
        assigns(:parking).should eq(parking)
      end

      it "does not update @parking's attributes" do
        put :update, { id: parking, parking: FactoryGirl.attributes_for(:invalid_parking, location: "Invalid location") }
        parking.reload
        parking.location.should_not eq("Invalid location")
      end

      it "re-renders the 'edit' template" do
        put :update, { id: parking, parking: FactoryGirl.attributes_for(:invalid_parking) }
        response.should render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before { @parking = FactoryGirl.create(:parking, user: user) }

    it "destroys the requested parking" do
      expect {
        delete :destroy, { id: @parking }
      }.to change(Parking, :count).by(-1)
    end

    it "redirects to the parkings list" do
      delete :destroy, { id: @parking }
      response.should redirect_to(parkings_path)
    end
  end
end
