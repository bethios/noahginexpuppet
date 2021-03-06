require 'sendgrid-ruby'

class PostsController < ApplicationController
  before_action :require_sign_in, except: [:about, :art, :puppets, :events, :hire, :send_inquiry]
  include SendGrid

  def index
    @posts = Post.all
  end

  def admin
  end

  def show
    find_post
  end

  def about
    @about_first = Post.where("category = '1' ").last
    @about_second = Post.where("category = '2' ").last
  end

  def art
    @art = Post.where("category = '4' ").last
    @art_projects = Project.where("category = '4' ")
  end

  def puppets
    @puppets = Post.where("category = '3' ").last
    @puppets_projects = Project.where("category = '3' ")
  end

  def events
    @event = Post.where("category = '5' ").last
    @event_projects = Project.where("category = '5' ")
  end

  def hire
    @hire = Post.where("category = '6' ").last
  end

  def send_inquiry
    name = params[:name]
    email = params[:email]
    body = params[:body]

    from = Email.new(email: email)
    to = Email.new(email: 'colonelernie@gmail.com')
    subject = email
    content = Content.new(type: 'text/plain', value: body)
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)

    flash[:notice] = "Thanks for your message! We will be in touch as soon as possible! Scroll down to play a game of Puppet Whack-a-mole"
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new
    if @post.update_attributes(post_params)
      flash[:notice] = "Saved!"
      redirect_to events_path
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    find_post
  end

  def update
    find_post
    if @post.update_attributes(post_params)
      flash[:notice] = "Saved!"
      redirect_to events_path
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    find_post

    if @post.destroy
      flash[:notice] = "Deleted!"
      redirect_to events_path
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
      redirect_to events_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category)
  end

  def find_post
    @post = Post.find(params[:id].to_i)
  end
end
