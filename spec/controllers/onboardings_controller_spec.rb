require 'spec_helper'

describe OnboardingsController do

  context "with an authenticated user" do
    let(:user) { create(:user) }
    before do
      user.confirm!
      sign_in user
    end

    describe "GET new" do

      it "redirects to root path" do
        get :new
        expect(response).to be_redirect
      end
    end

    describe "POST create" do

      it "redirects to root path" do
        post :create, { onboarding: {} }
        expect(response).to be_redirect
      end
    end
  end

  context "with an unauthenticated user" do
    describe "GET new" do
      before { get :new }

      it "assigns a new onboarding as @onboarding" do
        expect(assigns(:onboarding)).to be_a(Onboarding)
        expect(assigns(:onboarding)).not_to be_persisted
      end

      it "responds with success and render template" do
        expect(response).to be_success
        expect(response).to render_template :new
      end
    end

    describe "POST create" do
      context "with valid params" do
        let(:onboarding_attributes) { attributes_for(:onboarding) }

        it "creates a new Onboarding" do
          expect {
            post :create, { onboarding: onboarding_attributes }
          }.to change(User, :count).by(1) && change(Parking, :count).by(1) && change(Rent, :count).by(1)
        end

        it "assigns a newly created onboarding as @onboarding" do
          post :create, { onboarding: onboarding_attributes }
          expect(assigns(:onboarding)).to         be_a(Onboarding)
          expect(assigns(:onboarding).user).to    be_persisted
          expect(assigns(:onboarding).parking).to be_persisted
          expect(assigns(:onboarding).rent).to    be_persisted
        end

        context "when unconfirmed" do

          it "redirects to the root path" do
            post :create, { onboarding: onboarding_attributes }
            expect(response).to redirect_to(root_path)
          end
        end
      end

      context "with invalid params" do
        before { post :create, onboarding: attributes_for(:invalid_onboarding) }

        it "assigns a newly created but unsaved onboarding as @onboarding" do
          expect(assigns(:onboarding)).to be_a(Onboarding)
          expect(assigns(:onboarding)).not_to be_persisted
        end

        it { should render_template :new }
      end
    end
  end
end
