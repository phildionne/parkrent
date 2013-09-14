require 'spec_helper'

describe CheckoutsController do
  describe "GET new" do
    before { get :new }

    it "responds with success and render template" do
      expect(response).to be_success
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    let(:rent) { FactoryGirl.create(:rent) }

    context "with valid params" do
      let(:checkout_attributes) { FactoryGirl.attributes_for(:checkout, rent_id: rent.id) }

      it "creates a new Checkout" do
        expect {
          post :create, { checkout: checkout_attributes }
        }.to change(Order, :count).by(1) && change(User, :count).by(1) && change(Vehicle, :count).by(1)
      end

      it "assigns a newly created checkout as @checkout" do
        post :create, { checkout: checkout_attributes }
        expect(assigns(:checkout)).to be_a(Checkout)
        expect(assigns(:checkout).order).to be_persisted
        expect(assigns(:checkout).user).to be_persisted
        expect(assigns(:checkout).vehicle).to be_persisted
      end

      it "redirects to the newly created order" do
        post :create, { checkout: checkout_attributes }
        expect(response).to redirect_to(assigns(:checkout).order)
      end
    end

    context "with invalid params" do
      before { post :create, checkout: FactoryGirl.attributes_for(:invalid_checkout, rent_id: rent.id) }

      it "assigns a newly created but unsaved checkout as @checkout" do
        expect(assigns(:checkout)).to be_a(Checkout)
        expect(assigns(:checkout)).not_to be_persisted
      end

      it { should render_template :new }
    end
  end
end
