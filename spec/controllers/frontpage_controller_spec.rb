require 'spec_helper'

describe FrontpageController do

  context "with an authenticated user" do
    let(:user) { create(:user_with_vehicles) }
    before do
      user.confirm!
      sign_in user
    end

    describe "GET show" do
      before { get :show }

      it "responds with success and render template" do
        expect(response).to be_success
        expect(response).to render_template :homepage
      end
    end
  end

  context "with an unauthenticated user" do
    describe "GET show" do
      before { get :show }

      it "assigns a new onboarding as @onboarding" do
        expect(assigns(:onboarding)).to be_a(Onboarding)
        expect(assigns(:onboarding)).not_to be_persisted
      end

      it "responds with success and render template" do
        expect(response).to be_success
        expect(response).to render_template :frontpage
      end
    end
  end
end
