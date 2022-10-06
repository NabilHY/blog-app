class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments.includes([:author])
  end

  def new; end

  def create
    # @post = current_user.posts.new(post_params)
    @post.author = current_user
    respond_to do |format|
      if @post.save
        format.html do
          redirect_to user_posts_path(user_id: @post.author_id), notice: 'Post was successfully created.'
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
