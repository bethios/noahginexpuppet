require 'rails_helper'
include SessionsHelper

RSpec.describe WelcomeController, type: :controller do
  let(:admin) { User.create!(name: 'admin user', email: 'admin@admin.com', password: "helloworld")}

  context "guest" do
    describe "GET index" do
      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
    end

    describe "GET admin" do
      it "redirects to new session" do
        get :admin
        expect(response).to redirect_to(new_session_path)
      end
    end
  end

  context "admin" do
    before do
      create_session(admin)
    end

    describe "GET index" do
      it "renders the index template" do
        get :index
        expect(response).to render_template("index")
      end
    end

    describe "GET admin" do
      it "renders the admin template" do
        get :admin
        expect(response).to render_template("admin")
      end
    end
  end


end
