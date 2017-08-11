require 'rails_helper'
include SessionsHelper

RSpec.describe ProjectsController, type: :controller do
  let(:test_project) { Post.create!(title: 'test puppet post', category: 2)}
  let(:admin) { User.create!(name: 'admin user', email: 'admin@admin.com', password: "helloworld")}

  context "guest" do
    describe "GET index" do
      it "returns http redirect" do
        get :index
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "GET new" do
      it "returns http redirect" do
        get :new
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "GET create" do
      it "returns http redirect" do
        post :create, project: {title: 'test puppet post', category: 2}
        expect(response).to redirect_to(new_session_path)
      end
    end

    describe "DELETE destroy" do
      it "returns http redirect" do
        delete :destroy, id: test_project.id
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  context "admin" do
    before do
      create_session(admin)
    end


  end
end
