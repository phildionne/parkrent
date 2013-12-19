require 'spec_helper'

describe CommentsController do
  let(:parking) { create(:parking) }

  context "with an authenticated user" do
    let(:user) { create(:user) }
    before do
      user.confirm!
      sign_in user
    end

    describe "GET new" do
      before { get :new, parking_id: parking }

      it "assigns a new comment as @comment" do
        expect(assigns(:comment)).to be_a_new(Comment)
      end

      it "responds with success and render template" do
        expect(response).to be_success
        expect(response).to render_template :new
      end
    end

    describe "POST create" do
      context "with valid params" do
        let(:comment_attributes) { attributes_for(:comment) }

        it "creates a new Comment" do
          expect {
            post :create, { comment: comment_attributes, parking_id: parking }
            }.to change(Comment, :count).by(1)
        end

        it "assigns a newly created comment as @comment" do
          post :create, { comment: comment_attributes, parking_id: parking }
          expect(assigns(:comment)).to be_a(Comment)
          expect(assigns(:comment)).to be_persisted
        end

        it "redirects to the parking" do
          post :create, { comment: comment_attributes, parking_id: parking }
          expect(response).to redirect_to(assigns(:comment))
        end
      end

      context "with invalid params" do
        let(:comment_attributes) { attributes_for(:invalid_comment) }

        before { post :create, { comment: comment_attributes, parking_id: parking } }

        it "assigns a newly created but unsaved comment as @comment" do
          expect(assigns(:comment)).to be_a_new(Comment)
          expect(assigns(:comment)).not_to be_persisted
        end

        it { should render_template :new }
      end
    end
  end

  context "with an unauthenticated user" do
    let(:user)  { create(:user) }

    before { user.confirm! }

    describe "GET new" do

      it "redirects to root path" do
        get :new, parking_id: parking
        expect(response).to be_redirect
      end
    end

    describe "POST create" do

      it "redirects to root path" do
        post :create, { comment: {}, parking_id: parking }
        expect(response).to be_redirect
      end
    end
  end
end
