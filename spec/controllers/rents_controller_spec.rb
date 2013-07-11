require 'spec_helper'

describe RentsController do

  describe "GET index" do
    let(:parking) { FactoryGirl.create(:parking_with_rents) }

    before { get :index, { parking_id: parking } }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :index
    end
  end

  describe "GET show" do
    let(:parking) { FactoryGirl.create(:parking_with_rents) }
    let(:rent) { parking.rents.first }

    before { get :show, id: rent, parking_id: parking }

    it "assigns the rent as @rent" do
      assigns(:rent).should eq(rent)
    end

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :show
    end
  end

  describe "GET new" do
    let(:parking) { FactoryGirl.create(:parking) }

    before { get :new, parking_id: parking }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :new
    end
  end

  describe "POST create" do
    context "with valid params" do
      let(:parking) { FactoryGirl.create(:parking) }
      let(:rent_attributes) { FactoryGirl.attributes_for(:rent) }

      it "creates a new Rent" do
        expect {
          post :create, { rent: rent_attributes, parking_id: parking }
        }.to change(Rent, :count).by(1)
      end

      it "assigns a newly created rent as @rent" do
        post :create, { rent: rent_attributes, parking_id: parking }
        assigns(:rent).should be_a(Rent)
        assigns(:rent).should be_persisted
      end

      it "redirects to the created rent" do
        post :create, { rent: rent_attributes, parking_id: parking }
        response.should redirect_to(parking_rent_path(parking, Rent.last))
      end
    end

    context "with invalid params" do
      let(:parking) { FactoryGirl.create(:parking) }
      let(:invalid_rent_attributes) { FactoryGirl.attributes_for(:invalid_rent) }

      before do
        post :create, { rent: invalid_rent_attributes, parking_id: parking }
      end

      it "assigns a newly created but unsaved rent as @rent" do
        assigns(:rent).should be_a_new(Rent)
      end

      it { should render_template :new }
    end
  end

  describe "DELETE destroy" do
    before { @parking = FactoryGirl.create(:parking_with_rents) }
    let(:rent) { @parking.rents.first }

    it "destroys the requested rent" do
      expect {
        delete :destroy, { id: rent, parking_id: @parking }
      }.to change(Rent, :count).by(-1)
    end

    it "redirects to the rents list" do
      delete :destroy, { id: rent, parking_id: @parking }
      response.should redirect_to(parking_rents_path)
    end
  end

end
