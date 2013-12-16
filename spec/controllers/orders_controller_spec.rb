require 'spec_helper'

describe OrdersController do

  context "with an authenticated user" do
    let(:user) { create(:user_with_vehicles) }
    before do
      user.confirm!
      sign_in user
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
  end

  context "with an unauthenticated user" do
    let(:user)  { create(:user_with_vehicles) }
    let(:order) { create(:order, user: user) }

    before { user.confirm! }

    describe "GET show" do

      it "redirects to root path" do
        get :show, id: order
        expect(response).to be_redirect
      end
    end

    describe "GET edit" do

      it "redirects to root path" do
        get :edit, id: order
        expect(response).to be_redirect
      end
    end

    describe "PATCH update" do

      it "redirects to root path" do
        patch :update, { id: order, order: {}}
        expect(response).to be_redirect
      end
    end
  end
end
