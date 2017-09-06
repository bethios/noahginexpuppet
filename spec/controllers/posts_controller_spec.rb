require 'rails_helper'
include SessionsHelper

RSpec.describe PostsController, type: :controller do
  let(:about_post) { Post.create!(title: 'test about post', body: 'test about post body', category: 1)}
  let(:puppets_post) { Post.create!(title: 'test puppet post', body: 'test puppet post body', category: 2)}
  let(:art_post) { Post.create!( title: 'test art post', body: 'test art post body', category: 3)}
  let(:face_post) { Post.create!(title: 'test face painting post', body: 'test face painting post body', category: 4)}
  let(:hire_post) { Post.create!(title: 'test hire post', body: 'test hire me post body', category: 5)}
  let(:admin) { User.create!(name: 'admin user', email: 'admin@admin.com', password: "helloworld")}

  context "guest" do
    describe "GET art" do
      it "returns http success" do
        get :art, title: art_post.title, body: art_post.body, category: art_post.category
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET puppets" do
      it "returns http success" do
        get :puppets, title: puppets_post.title, body: puppets_post.body, category: puppets_post.category
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET events" do
      it "returns http success" do
        get :events, title: face_post.title, body: face_post.body, category: face_post.category
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET about" do
      it "returns http success" do
        get :about, title: about_post.title, body: about_post.body, category: about_post.category
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET hire" do
      it "returns http success" do
        get :hire, title: hire_post.title, body: hire_post.body, category: hire_post.category
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "POST create" do
      it "returns http redirect" do
        post :create, post: {title: art_post.title, body: art_post.body, category: art_post.category}
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "GET index" do
      it "returns http redirect" do
        get :index
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "GET edit" do
      it "returns http redirect" do
        get :edit, id: art_post.id
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "PUT update" do
      it "returns http redirect" do
        new_title = "new title test"
        new_body = "new post body"
        new_category = 2

        put :update, id: art_post.id, post: {title: new_title, body: new_body, category: new_category}
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, id: art_post.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  context "admin" do
    before do
      create_session(admin)
    end

    describe "GET art" do
      it "returns http success" do
        get :art, title: art_post.title, body: art_post.body, category: art_post.category
        expect(response).to have_http_status(:success)
      end
    end
    describe "GET puppets" do
      it "returns http success" do
        get :puppets, title: puppets_post.title, body: puppets_post.body, category: puppets_post.category
        expect(response).to have_http_status(:success)
      end
    end
    describe "GET events" do
      it "returns http success" do
        get :events, title: face_post.title, body: face_post.body, category: face_post.category
        expect(response).to have_http_status(:success)
      end
    end
    describe "GET about" do
      it "returns http success" do
        get :about, title: about_post.title, body: about_post.body, category: about_post.category
        expect(response).to have_http_status(:success)
      end
    end
    describe "GET hire" do
      it "returns http success" do
        get :hire, title: hire_post.title, body: hire_post.body, category: hire_post.category
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the #new view" do
        get :new, id: puppets_post.id
        expect(response).to render_template :new
      end

      it "instantiates @post" do
        get :new
        expect(assigns(:post)).not_to be_nil
      end
    end

    describe "POST create" do
      it "returns http success" do
        expect { post :create, post:{title: 'test hire post', body: 'test hire me post body', category: 5}}
      end

      it "assigns the new post to @post" do
        post :create, post:{title: 'test hire post', body: 'test hire me post body', category: 5}
        expect(assigns(:post)).to eq Post.last
      end

      it "redirects to admin path" do
        post :create, post:{title: 'test hire post', body: 'test hire me post body', category: 5}
        expect(response).to redirect_to admin_path
      end
    end

    describe "GET edit" do
      it "returns http sucess" do
        get :edit, id: puppets_post.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, id: puppets_post.id
        expect(response).to render_template :edit
      end

      it "assigns post to updated to @post" do
        get :edit, id: puppets_post.id
        post_instance = assigns(:post)

        expect(post_instance.id).to eq puppets_post.id
        expect(post_instance.title).to eq puppets_post.title
        expect(post_instance.body).to eq puppets_post.body
        expect(post_instance.category).to eq puppets_post.category
      end
    end

    describe "PUT update" do
      it "updates post with expected attributes" do
        new_title = "new title test"
        new_body = "new post body"
        new_category = 2

        put :update, id: puppets_post.id, post: {title: new_title, body: new_body, category: new_category}
        updated_post = assigns(:post)
        expect(updated_post.id).to eq puppets_post.id
        expect(updated_post.title).to eq new_title
        expect(updated_post.body).to eq new_body
        expect(updated_post.category).to eq new_category
      end

      it "redirects to admin path" do
        new_title = "new title test"
        new_body = "new post body"
        new_category = 2
        put :update, id: art_post.id, post: {title: new_title, body: new_body, category: new_category}
        expect(response).to redirect_to admin_path
      end
    end

    describe "DELETE destroy" do
      it "deletes the post" do
        delete :destroy, id: hire_post.id
        count = Post.where({id: hire_post.id}).size
        expect(count).to eq 0
      end

      it "redirects to admin path" do
        delete :destroy, id: hire_post.id
        expect(response).to redirect_to admin_path
      end
    end
  end
end
