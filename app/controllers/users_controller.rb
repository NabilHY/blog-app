class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = User.recent_posts(params[:id])
  end

  def user_posts_api
    @posts = User.find(params[:id]).posts
    render json: @posts, only: %i[id author_id post_counter likes_counter title text], status: :ok
  end
end
