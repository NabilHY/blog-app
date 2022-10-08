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
    @post = current_user.posts.new(post_params)
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

  def destroy
    @post = Post.find(params[:id])
    @user = User.find(@post.author_id)
    @user.post_counter -= 1
    @post.destroy
    @user.save
    redirect_to user_posts_path(user_id: @post.author_id), notice: 'Post was successfully deleted.'
  end

  def post_comments_api
    @post = Post.find(params[:id])
    @comments = @post.comments.includes([:author])
    render json: @comments, only: %i[id author_id post_id text], status: :ok
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
