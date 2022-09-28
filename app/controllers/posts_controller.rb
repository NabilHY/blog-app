class PostsController < ApplicationController
  def index
    @posts = User.find(params[:id]).posts
  end

  def show; end
end
