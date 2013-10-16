require 'spec_helper'

describe VehiclesController do
  # @FIXME Consider adding context to test a signed in/signed out usecase
  let(:user) { create(:user) }
  before do
    user.confirm!
    sign_in user
  end

  describe "GET new" do
    before { get :new }

    it "assigns a new vehicle as @vehicle" do
      expect(assigns(:vehicle)).to be_a_new(Vehicle)
    end

    it "responds with success and render template" do
      expect(response).to be_success
      expect(response).to render_template :new
    end
  end

  describe "GET edit" do
    let(:vehicle) { create(:vehicle, user: user) }

    before { get :edit, id: vehicle }

    it "assigns the requested vehicle to @vehicle" do
      expect(assigns(:vehicle)).to eq(vehicle)
    end

    it "responds with success and render template" do
      expect(response).to be_success
      expect(response).to render_template :edit
    end
  end

  describe "POST create" do
    context "with valid params" do
      let(:vehicle_attributes) { attributes_for(:vehicle) }

      it "creates a new Vehicle" do
        expect {
          post :create, { vehicle: vehicle_attributes }
        }.to change(Vehicle, :count).by(1)
      end

      it "assigns a newly created vehicle as @vehicle" do
        post :create, { vehicle: vehicle_attributes }
        expect(assigns(:vehicle)).to be_a(Vehicle)
        expect(assigns(:vehicle)).to be_persisted
      end

      it "redirects to the dashboard" do
        post :create, { vehicle: vehicle_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      before { post :create, vehicle: attributes_for(:invalid_vehicle) }

      it "assigns a newly created but unsaved vehicle as @vehicle" do
        expect(assigns(:vehicle)).to be_a_new(Vehicle)
        expect(assigns(:vehicle)).not_to be_persisted
      end

      it { should render_template :new }
    end
  end

  describe "PATCH update" do
    let(:vehicle) { create(:vehicle, license_plate: "ABC 000", user: user) }

    context "with valid params" do
      it "assigns the requested vehicle as @vehicle" do
        patch :update, { id: vehicle, vehicle: attributes_for(:vehicle)}
        expect(assigns(:vehicle)).to eq(vehicle)
      end

      it "updates the requested vehicle" do
        patch :update, { id: vehicle, vehicle: attributes_for(:vehicle, license_plate: "ABC 123") }
        vehicle.reload
        expect(vehicle.license_plate).to eq("ABC 123")
      end

      it "redirects to the dashboard" do
        patch :update, { id: vehicle, vehicle: attributes_for(:vehicle) }
        vehicle.reload
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "assigns the vehicle as @vehicle" do
        patch :update, { id: vehicle, vehicle: attributes_for(:invalid_vehicle) }
        expect(assigns(:vehicle)).to eq(vehicle)
      end

      it "does not update @vehicle's attributes" do
        patch :update, { id: vehicle, vehicle: attributes_for(:invalid_vehicle, license_plate: "123") }
        vehicle.reload
        expect(vehicle.license_plate).to_not eq("123")
      end

      it "re-renders the 'edit' template" do
        patch :update, { id: vehicle, vehicle: attributes_for(:invalid_vehicle) }
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    let(:vehicle) { create(:vehicle, user: user) }

    it "destroys the requested vehicle" do
      expect {
        delete :destroy, { id: vehicle }
      }.to change(Vehicle, :count).by(-1)
    end

    it "redirects to the dashboard" do
      delete :destroy, { id: vehicle }
      expect(response).to redirect_to(root_path)
    end
  end
end
