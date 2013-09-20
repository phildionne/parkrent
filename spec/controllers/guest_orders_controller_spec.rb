require 'spec_helper'

describe GuestOrdersController do
  describe "GET new" do
    before { get :new }

    it "assigns a new guest_order as @guest_order" do
      expect(assigns(:guest_order)).to be_a_new(GuestOrder)
    end

    it "responds with success and render template" do
      expect(response).to be_success
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    let(:rent) { create(:rent) }

    context "with valid params" do
      let(:guest_order_attributes) { attributes_for(:guest_order, rent_id: rent.id) }

      it "creates a new GuestOrder" do
        expect {
          post :create, { guest_order: guest_order_attributes }
        }.to change(Order, :count).by(1) && change(User, :count).by(1) && change(Vehicle, :count).by(1)
      end

      it "assigns a newly created guest_order as @guest_order" do
        post :create, { guest_order: guest_order_attributes }
        expect(assigns(:guest_order)).to be_a(GuestOrder)
        expect(assigns(:guest_order).order).to be_persisted
        expect(assigns(:guest_order).user).to be_persisted
        expect(assigns(:guest_order).vehicle).to be_persisted
      end

      it "assigns the correct rent" do
        post :create, { guest_order: guest_order_attributes }
        expect(assigns(:guest_order).rent).to eq(rent)
      end

      it "redirects to the newly created order" do
        post :create, { guest_order: guest_order_attributes }
        expect(response).to redirect_to(assigns(:guest_order).order)
      end
    end

    context "with invalid params" do
      before { post :create, guest_order: attributes_for(:invalid_guest_order, rent_id: rent.id) }

      it "assigns a newly created but unsaved guest_order as @guest_order" do
        expect(assigns(:guest_order)).to be_a(GuestOrder)
        expect(assigns(:guest_order)).not_to be_persisted
      end

      it { should render_template :new }
    end
  end
end