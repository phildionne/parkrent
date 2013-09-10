require 'spec_helper'

describe FrontpageController do

  describe "GET show" do

    context "with an authenticated user" do
      before do
        get :show
      end

      it "responds with success and render template" do
        expect(response).to be_success
        expect(response).to render_template :homepage
      end
    end

    context "with an unauthenticated user" do
      before { get :show }

      it "responds with success and render template" do
        expect(response).to be_success
        expect(response).to render_template :frontpage
      end
    end
  end
end
