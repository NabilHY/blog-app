class CommentsController < ApplicationController
  load_and_authorize_resource
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      redirect_to user_post_path(@post.author_id, @post.id), notice: 'Comment was successfully created.'
    else
      render :new, alert: 'Comment not saved'
    end
    @post.update_comments_counter
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    @post.save
    @post.update_comments_counter
    redirect_to user_post_path(@post.author_id, @post.id), notice: 'Comment was successfully deleted.'
  end

  def post_create_api
    @post = Post.find(params[:id])
    @comment = current_user.comments.new(comment_params)
    if @comment.save
      render json: @comment, only: %i[id author_id post_id text], status: :ok
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(post_id: params[:post_id])
  end
end
