require 'spec_helper'

describe RentsController do
  describe "GET index" do
    before { get :index }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :index
    end
  end

  describe "GET show" do
    let(:rent) { FactoryGirl.create(:rent) }

    before { get :show, id: rent }

    it "assigns the rent as @rent" do
      assigns(:rent).should eq(rent)
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
    let(:rent) { FactoryGirl.create(:rent) }

    before { get :edit, id: rent }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :edit
    end
  end

  describe "POST create" do
    context "with valid params" do
      let(:rent_attributes) { FactoryGirl.attributes_for(:rent) }

      it "creates a new Rent" do
        expect {
          post :create, { rent: rent_attributes }
        }.to change(Rent, :count).by(1)
      end

      it "assigns a newly created rent as @rent" do
        post :create, { rent: rent_attributes }
        assigns(:rent).should be_a(Rent)
        assigns(:rent).should be_persisted
      end

      it "redirects to the created rent" do
        post :create, { rent: rent_attributes }
        response.should redirect_to(Rent.last)
      end
    end

    context "with invalid params" do
      before { post :create, rent: FactoryGirl.attributes_for(:invalid_rent) }

      it "assigns a newly created but unsaved rent as @rent" do
        assigns(:rent).should be_a_new(Rent)
      end

      it { should render_template :new }
    end
  end

  describe "PUT update" do
    let(:rent) { FactoryGirl.create(:rent, price: 100, beginning: Date.tomorrow) }

    context "with valid params" do
      it "assigns the requested rent as @rent" do
        put :update, { id: rent, rent: FactoryGirl.attributes_for(:rent)}
        assigns(:rent).should eq(rent)
      end

      it "updates the requested rent" do
        put :update, { id: rent, rent: FactoryGirl.attributes_for(:rent, price: "invalid price", beginning: Date.yesterday) }
        rent.reload
        rent.price.should eq(100)
        rent.beginning.should eq(Date.tomorrow)
      end

      it "redirects to the rent" do
        put :update, { id: rent, rent: FactoryGirl.attributes_for(:rent) }
        rent.reload
        response.should redirect_to(rent)
      end
    end

    context "with invalid params" do
      it "assigns the rent as @rent" do
        put :update, { id: rent, rent: FactoryGirl.attributes_for(:invalid_rent) }
        assigns(:rent).should eq(rent)
      end

      it "does not update @rent's attributes" do
        put :update, { id: rent, rent: FactoryGirl.attributes_for(:invalid_rent, price: "invalid price") }
        rent.reload
        rent.price.should_not eq("invalid price")
        rent.beginning.should eq(Date.tomorrow)
      end

      it "re-renders the 'edit' template" do
        put :update, { id: rent, rent: FactoryGirl.attributes_for(:invalid_rent) }
        response.should render_template :edit
      end
    end
  end

  describe "DELETE destroy" do
    before { @rent = FactoryGirl.create(:rent) }

    it "destroys the requested rent" do
      expect {
        delete :destroy, { id: @rent }
      }.to change(Rent, :count).by(-1)
    end

    it "redirects to the rents list" do
      delete :destroy, { id: @rent }
      response.should redirect_to(rents_path)
    end
  end
end
