require 'spec_helper'

describe OrdersController do
  # @FIXME Consider adding context to test a signed in/signed out usecase
  let(:user) { create(:user_with_vehicles) }
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
    let(:order) { create(:order, user: user, vehicle: user.vehicles.sample) }

    before { get :show, id: order }

    it "assigns the order as @order" do
      expect(assigns(:order)).to eq(order)
    end

    it "responds with success and render template" do
      expect(response).to be_success
      expect(response).to render_template :show
    end
  end

  describe "GET new" do
    context "with valid params" do
      let(:rent) { create(:rent) }

      before { get :new, { rent_id: rent.id } }

      it "assigns a new order as @order" do
        expect(assigns(:order)).to be_a_new(Order)
      end

      it "assigns the correct rent as @rent" do
        expect(assigns(:rent)).to eq(rent)
      end

      it "assigns a new vehicle as @vehicle" do
        expect(assigns(:vehicle)).to be_a_new(Vehicle)
      end

      it "responds with success and render template" do
        expect(response).to be_success
        expect(response).to render_template :new
      end
    end

    context "with invalid params" do
      it "raises an error" do
        expect {
          get :new, { rent_id: nil }
        }.to raise_error
      end
    end
  end

  describe "GET edit" do
    let(:order) { create(:order, user: user, vehicle: user.vehicles.sample) }

    before { get :edit, id: order }

    it "assigns the requested order as @order" do
      expect(assigns(:order)).to eq(order)
    end

    it "assigns a new vehicle as @vehicle" do
      expect(assigns(:vehicle)).to be_a_new(Vehicle)
    end

    it "responds with success and render template" do
      expect(response).to be_success
      expect(response).to render_template :edit
    end
  end

  describe "POST create" do
    context "with valid params" do
      let(:rent)             { create(:rent) }
      let(:vehicle)          { create(:vehicle, user: user) }
      let(:order_attributes) { attributes_for(:order).merge(rent_id: rent.id).merge(vehicle_id: vehicle.id) }

      it "creates a new Order" do
        expect {
          post :create, { order: order_attributes }
        }.to change(Order, :count).by(1)
      end

      it "assigns a newly created order as @order" do
        post :create, { order: order_attributes }
        expect(assigns(:order)).to be_a(Order)
        expect(assigns(:order)).to be_persisted
      end

      it "redirects to the created order" do
        post :create, { order: order_attributes }
        expect(response).to redirect_to(assigns(:order))
      end
    end

    context "with invalid params" do
      let(:order_attributes) { attributes_for(:invalid_order).merge(rent_id: nil).merge(vehicle_id: nil) }

      before { post :create, { order: order_attributes } }

      it "assigns a newly created but unsaved order as @order" do
        expect(assigns(:order)).to be_a_new(Order)
        expect(assigns(:order)).not_to be_persisted
      end

      it { should render_template :new }
    end

    context "when creating a vehicle" do
      context "with valid params" do
        let(:rent)               { create(:rent) }
        let(:order_attributes)   { attributes_for(:order).merge(rent_id: rent.id) }
        let(:vehicle_attributes) { attributes_for(:vehicle) }

        it "creates a new Vehicle" do
          # Force the block to be evaluated, workaround for order factory eager creation
          order_attributes

          expect {
            post :create, { order: order_attributes, vehicle: vehicle_attributes }
          }.to change(Vehicle, :count).by(1)
        end
      end

      context "with invalid params" do
        let(:order_attributes)   { attributes_for(:invalid_order).merge(rent_id: nil) }
        let(:vehicle_attributes) { attributes_for(:invalid_vehicle) }

        before { post :create, { order: order_attributes, vehicle: vehicle_attributes } }

        it "assigns a newly created but unsaved vehicle as @vehicle" do
          expect(assigns(:vehicle)).to be_a_new(Vehicle)
          expect(assigns(:vehicle)).not_to be_persisted
        end
      end
    end
  end

  describe "PATCH update" do
    let(:order) { create(:order, user: user, vehicle: user.vehicles.sample) }

    context "with valid params" do
      let(:rent)             { create(:rent) }
      let(:vehicle)          { create(:vehicle, user: user) }
      let(:order_attributes) { attributes_for(:order).merge(rent_id: rent.id).merge(vehicle_id: vehicle.id) }

      it "assigns the requested order as @order" do
        patch :update, { id: order, order: order_attributes }
        expect(assigns(:order)).to eq(order)
      end

      it "updates the requested order" do
        patch :update, { id: order, order: order_attributes }
        order.reload
        expect(order.rent).to eq(rent)
        expect(order.vehicle).to eq(vehicle)
      end

      it "redirects to the order" do
        patch :update, { id: order, order: order_attributes }
        order.reload
        expect(response).to redirect_to(order)
      end
    end

    context "with invalid params" do
      let(:rent)             { create(:rent) }
      let(:order_attributes) { attributes_for(:invalid_order).merge(rent_id: rent.id).merge(vehicle_id: nil) }

      it "assigns the order as @order" do
        patch :update, { id: order, order: order_attributes }
        expect(assigns(:order)).to eq(order)
      end

      it "does not update @order's attributes" do
        patch :update, { id: order, order: order_attributes }
        order.reload
        expect(order.rent).not_to eq(rent)
      end

      it "re-renders the 'edit' template" do
        patch :update, { id: order, order: order_attributes }
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before { @order = create(:order, user: user, vehicle: user.vehicles.sample) }

    it "destroys the requested order" do
      expect {
        delete :destroy, { id: @order }
      }.to change(Order, :count).by(-1)
    end

    it "redirects to the orders list" do
      delete :destroy, { id: @order }
      expect(response).to redirect_to(orders_path)
    end
  end
end
