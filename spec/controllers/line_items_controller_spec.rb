require 'spec_helper'

describe LineItemsController do

  describe "GET index" do
    let(:order) { FactoryGirl.create(:order_with_line_items) }

    before { get :index, { order_id: order } }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :index
    end
  end

  describe "GET show" do
    let(:order) { FactoryGirl.create(:order_with_line_items) }
    let(:line_item) { order.line_items.first }

    before { get :show, id: line_item, order_id: order }

    it "assigns the line_item as @line_item" do
      assigns(:line_item).should eq(line_item)
    end

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :show
    end
  end

  describe "GET new" do
    let(:order) { FactoryGirl.create(:order) }

    before { get :new, order_id: order }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :new
    end
  end

  describe "POST create" do
    context "with valid params" do
      let(:order) { FactoryGirl.create(:order) }
      let(:line_item_attributes) { FactoryGirl.attributes_for(:line_item) }

      it "creates a new LineItem" do
        expect {
          post :create, { line_item: line_item_attributes, order_id: order }
        }.to change(LineItem, :count).by(1)
      end

      it "assigns a newly created line_item as @line_item" do
        post :create, { line_item: line_item_attributes, order_id: order }
        assigns(:line_item).should be_a(LineItem)
        assigns(:line_item).should be_persisted
      end

      it "redirects to the created line_item" do
        post :create, { line_item: line_item_attributes, order_id: order }
        response.should redirect_to(order_line_item_path(order, LineItem.last))
      end
    end

    context "with invalid params" do
      let(:order) { FactoryGirl.create(:order) }
      let(:invalid_line_item_attributes) { FactoryGirl.attributes_for(:invalid_line_item) }

      before do
        post :create, { line_item: invalid_line_item_attributes, order_id: order }
      end

      it "assigns a newly created but unsaved line_item as @line_item" do
        assigns(:line_item).should be_a_new(LineItem)
      end

      it { should render_template :new }
    end
  end

  describe "DELETE destroy" do
    before { @order = FactoryGirl.create(:order_with_line_items) }
    let(:line_item) { @order.line_items.first }

    it "destroys the requested line_item" do
      expect {
        delete :destroy, { id: line_item, order_id: @order }
      }.to change(LineItem, :count).by(-1)
    end

    it "redirects to the line_items list" do
      delete :destroy, { id: line_item, order_id: @order }
      response.should redirect_to(order_line_items_path)
    end
  end

end
