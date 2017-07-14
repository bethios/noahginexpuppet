class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def admin
  end

  def show
    find_post
  end

  def about
    @about = Post.where("category = '1' ").last
  end

  def art
    @art = Post.where("category = '3' ").last
  end

  def puppets
    @puppets = Post.where("category = '2' ").last
  end

  def face_painting
    @face_painting = Post.where("category = '4' ").last
  end

  def send_inquiry
    name = params[:name]
    email = params[:email]
    body = params[:body]
    InquiryMailer.new_inquiry(email, name, body).deliver_now

    if InquiryMailer.new_inquiry(email, name, body).deliver_now
      flash.now[:alert] = "Message sent!"
      redirect_to :back
    else
      flash.now[:alert] = "Problem sending message"
      redirect_to :back
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new
    if @post.update_attributes(post_params)
      flash[:notice] = "Saved!"
      redirect_to admin_path
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
      redirect_to admin_path
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    find_post

    if @post.destroy
      flash[:notice] = "Deleted!"
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
      redirect_to admin_path
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
