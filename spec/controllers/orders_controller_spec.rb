require 'spec_helper'

describe OrdersController do
  let(:user) { FactoryGirl.create(:user_with_vehicles) }
  before { sign_in user }

  describe "GET index" do
    before { get :index }

    it "responds with success and render template" do
      expect(response).to be_success
      expect(response).to render_template :index
    end
  end

  describe "GET show" do
    let(:order) { FactoryGirl.create(:order, user: user) }

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
    let(:rent) { FactoryGirl.create(:rent) }

    before { get :new, rent_id: rent }

    it "responds with success and render template" do
      expect(response).to be_success
      expect(response).to render_template :new
    end
  end

  describe "GET edit" do
    let(:order) { FactoryGirl.create(:order, user: user) }

    before { get :edit, id: order }

    it "responds with success and render template" do
      expect(response).to be_success
      expect(response).to render_template :edit
    end
  end

  describe "POST create" do
    context "with valid params" do
      let(:order_attributes) { FactoryGirl.attributes_for(:order) }

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
        expect(response).to redirect_to(Order.last)
      end
    end

    context "with invalid params" do
      before { post :create, order: FactoryGirl.attributes_for(:invalid_order) }

      it "assigns a newly created but unsaved order as @order" do
        expect(assigns(:order)).to be_a_new(Order)
      end

      it { should render_template :new }
    end
  end

  describe "PUT update" do
    let(:rent) { FactoryGirl.create(:rent) }
    let(:other_rent) { FactoryGirl.create(:rent) }
    let(:order) { FactoryGirl.create(:order, rent: rent, user: user) }

    context "with valid params" do
      it "assigns the requested order as @order" do
        put :update, { id: order, order: FactoryGirl.attributes_for(:order)}
        expect(assigns(:order)).to eq(order)
      end

      it "updates the requested order" do
        put :update, { id: order, order: FactoryGirl.attributes_for(:order, rent: other_rent) }
        order.reload
        expect(order.rent).to eq(other_rent)
      end

      it "redirects to the order" do
        put :update, { id: order, order: FactoryGirl.attributes_for(:order) }
        order.reload
        expect(response).to redirect_to(order)
      end
    end

    context "with invalid params" do
      it "assigns the order as @order" do
        put :update, { id: order, order: FactoryGirl.attributes_for(:invalid_order) }
        expect(assigns(:order)).to eq(order)
      end

      it "does not update @order's attributes" do
        put :update, { id: order, order: FactoryGirl.attributes_for(:invalid_order, rent: "Invalid rent") }
        order.reload
        order.rent.should_not eq("Invalid rent")
      end

      it "re-renders the 'edit' template" do
        put :update, { id: order, order: FactoryGirl.attributes_for(:invalid_order) }
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before { @order = FactoryGirl.create(:order, user: user) }

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
