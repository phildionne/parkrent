require 'spec_helper'

describe OrdersController do
  let(:user) { FactoryGirl.create(:user_with_vehicles) }
  before { sign_in user }

  describe "GET index" do
    before { get :index }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :index
    end
  end

  describe "GET show" do
    let(:order) { FactoryGirl.create(:order, user: user) }

    before { get :show, id: order }

    it "assigns the order as @order" do
      assigns(:order).should eq(order)
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
    let(:order) { FactoryGirl.create(:order, user: user) }

    before { get :edit, id: order }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :edit
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
        assigns(:order).should be_a(Order)
        assigns(:order).should be_persisted
      end

      it "redirects to the created order" do
        post :create, { order: order_attributes }
        response.should redirect_to(Order.last)
      end
    end

    context "with invalid params" do
      before { post :create, order: FactoryGirl.attributes_for(:invalid_order) }

      it "assigns a newly created but unsaved order as @order" do
        assigns(:order).should be_a_new(Order)
      end

      it { should render_template :new }
    end
  end

  describe "PUT update" do
    let(:order) { FactoryGirl.create(:order, location: "Somewhere") }

    context "with valid params" do
      it "assigns the requested order as @order" do
        put :update, { id: order, order: FactoryGirl.attributes_for(:order)}
        assigns(:order).should eq(order)
      end

      it "updates the requested order" do
        put :update, { id: order, order: FactoryGirl.attributes_for(:order, location: "Somewhere else") }
        order.reload
        order.location.should eq("Somewhere else")
      end

      it "redirects to the order" do
        put :update, { id: order, order: FactoryGirl.attributes_for(:order) }
        order.reload
        response.should redirect_to(order)
      end
    end

    context "with invalid params" do
      it "assigns the order as @order" do
        put :update, { id: order, order: FactoryGirl.attributes_for(:invalid_order) }
        assigns(:order).should eq(order)
      end

      it "does not update @order's attributes" do
        put :update, { id: order, order: FactoryGirl.attributes_for(:invalid_order, location: "Invalid location") }
        order.reload
        order.location.should_not eq("Invalid location")
      end

      it "re-renders the 'edit' template" do
        put :update, { id: order, order: FactoryGirl.attributes_for(:invalid_order) }
        response.should render_template :edit
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
      response.should redirect_to(orders_path)
    end
  end
end
