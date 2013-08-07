require 'spec_helper'

describe OnboardingsController do
  describe "GET new" do
    before { get :new }

    it "responds with success and render template" do
      response.should be_success
      response.should render_template :new
    end
  end

  describe "POST create" do
    context "with valid params" do
      let(:onboarding_attributes) { FactoryGirl.attributes_for(:onboarding) }

      it "creates a new Onboarding" do
        expect {
          post :create, { onboarding: onboarding_attributes }
        }.to change(User, :count).by(1) && change(Parking, :count).by(1) && change(Rent, :count).by(1)
      end

      it "assigns a newly created onboarding as @onboarding" do
        post :create, { onboarding: onboarding_attributes }
        assigns(:onboarding).should be_a(Onboarding)
        assigns(:onboarding).should be_persisted
      end

      it "redirects to the frontpage" do
        post :create, { onboarding: onboarding_attributes }
        response.should redirect_to(root_path)
      end
    end

    context "with invalid params" do
      before { post :create, onboarding: FactoryGirl.attributes_for(:invalid_onboarding) }

      it "assigns a newly created but unsaved onboarding as @onboarding" do
        assigns(:onboarding).should be_a_new(Onboarding)
      end

      it { should render_template :new }
    end
  end
end
