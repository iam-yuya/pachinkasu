class PostsController < ApplicationController

  def index
    @post = Post.new
    @posts = Post.all
    @post_new = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id), notice: "You have created post successfully."
    else
      render 'index'
    end
  end

  def show
    @post = Post.find(params[:id])
  end


  def edit
  end

  def update
  end

  def destroy
  end
end
