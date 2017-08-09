class WelcomeController < ApplicationController
  before_action 'require_sign_in', except: :index

  def admin
  end

  def index
  end
end
