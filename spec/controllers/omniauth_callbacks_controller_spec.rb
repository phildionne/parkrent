require 'spec_helper'

describe OmniauthCallbacksController do
  before { request.env["devise.mapping"] = Devise.mappings[:user] }

  OmniAuth.config.add_mock(:twitter, {:uid => '12345'})

  describe :stripe_connect do

    context "with a valid auth hash" do
      before { request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:stripe_connect] }

      describe "inexisting User" do

        it "redirects to root path" do
          get :stripe_connect, { state: nil, scope: 'read_write', code: '1234' }
          expect(response).to redirect_to(root_path)
        end
      end

      describe "existing User and existing StripeAccount" do
        let(:user)           { create(:user) }
        let(:stripe_account) { create(:stripe_account, user: user) }

        it "redirects to root path" do
          get :stripe_connect, { state: user.id, scope: 'read_write', code: '1234' }
          expect(response).to redirect_to(root_path)
        end
      end

      describe "existing User and inexisting StripeAccount" do
        let(:user) { create(:user) }

        context "with a valid StripeAccount" do

          it "creates a new StripeAccount" do
            expect {
              get :stripe_connect, { state: user.id, scope: 'read_write', code: '1234' }
            }.to change(StripeAccount, :count).by(1)
          end

          it "redirects to root path" do
            get :stripe_connect, { state: user.id, scope: 'read_write', code: '1234' }
            expect(response).to redirect_to(root_path)
          end
        end

        context "with an invalid StripeAccount" do
          before do
            request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:stripe_connect]
            request.env['omniauth.auth'][:extra][:raw_info][:stripe_publishable_key] = nil
          end

          it "redirects to root path" do
            get :stripe_connect, { state: user.id, scope: 'read_write', code: '1234' }
            expect(response).to redirect_to(root_path)
          end
        end
      end
    end

    context "with an invalid auth hash" do
      let(:user) { create(:user) }

      before { request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:invalid_stripe_connect] }

      it "redirects to root path" do
        get :stripe_connect, { state: user.id, scope: 'read_write', code: '1234' }
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
