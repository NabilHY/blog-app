class PostsController < ApplicationController
  def index
      @user = User.find(params[:user_id])
      @posts = User.find(params[:user_id]).posts
  end

  def show 
      @user = User.find(params[:user_id])
      @post = Post.find(params[:id])
      @comments = Post.five_recent_comments(params[:id])
  end
end
