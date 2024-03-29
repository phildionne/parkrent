require 'spec_helper'

describe RentsController do

  context "with an authenticated user" do
    let(:user) { create(:user) }
    before do
      user.confirm!
      sign_in user
    end

    describe "GET new" do
      let(:parking) { create(:parking, user: user) }

      before { get :new, parking_id: parking }

      it "assigns a new rent as @rent" do
        expect(assigns(:rent)).to be_a_new(Rent)
      end

      it "builds a new schedule" do
        expect(assigns(:rent).schedule).to be_a_new(Schedule)
      end

      it "responds with success and render template" do
        expect(response).to be_success
        expect(response).to render_template :new
      end
    end

    describe "POST create" do
      context "with valid params" do
        let(:parking) { create(:parking, user: user) }
        let(:rent_attributes) { attributes_for(:rent).merge({ schedule_attributes: attributes_for(:schedule) }) }

        it "creates a new Rent" do
          expect {
            post :create, { rent: rent_attributes, parking_id: parking }
          }.to change(Rent, :count).by(1)
        end

        it "assigns a newly created rent as @rent" do
          post :create, { rent: rent_attributes, parking_id: parking }
          expect(assigns(:rent)).to be_a(Rent)
          expect(assigns(:rent)).to be_persisted
        end

        it "redirects to the created rent" do
          post :create, { rent: rent_attributes, parking_id: parking }
          expect(response).to redirect_to(parking_path(parking))
        end
      end

      context "with invalid params" do
        let(:parking) { create(:parking, user: user) }
        let(:invalid_rent_attributes) { attributes_for(:invalid_rent).merge({ schedule_attributes: attributes_for(:invalid_schedule) }) }

        before do
          post :create, { rent: invalid_rent_attributes, parking_id: parking }
        end

        it "assigns a newly created but unsaved rent as @rent" do
          expect(assigns(:rent)).to be_a_new(Rent)
          expect(assigns(:rent)).not_to be_persisted
        end

        it { should render_template :new }
      end
    end

    describe "DELETE destroy" do
      let!(:parking) { create(:parking_with_rents, user: user) }
      let(:rent)     { parking.rents.first }

      it "destroys the requested rent" do
        expect {
          delete :destroy, { id: rent, parking_id: parking }
        }.to change(Rent, :count).by(-1)
      end

      it "redirects to the rents list" do
        delete :destroy, { id: rent, parking_id: parking }
        expect(response).to redirect_to(parking_path(parking))
      end
    end
  end

  context "with an unauthenticated user" do
    let(:user)    { create(:user) }
    let(:parking) { create(:parking_with_rents, user: user) }
    let(:rent)    { parking.rents.sample }

    before { user.confirm! }

    describe "GET new" do
      before { get :new, parking_id: parking }

      it "redirects to root path" do
        expect(response).to be_redirect
      end
    end

    describe "GET edit" do
      before { get :edit, { id: rent, parking_id: parking } }

      it "redirects to root path" do
        expect(response).to be_redirect
      end
    end

    describe "POST create" do
      it "redirects to root path" do
        post :create, { parking_id: parking, rent: {}}
        expect(response).to be_redirect
      end
    end

    describe "PATCH update" do
      it "redirects to root path" do
        patch :update, { id: rent, parking_id: parking, rent: {}}
        expect(response).to be_redirect
      end
    end

    describe "DELETE destroy" do
      it "redirects to root path" do
        delete :destroy, { id: rent, parking_id: parking }
        expect(response).to be_redirect
      end
    end
  end
end
