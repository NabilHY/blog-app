class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = current_user.likes.new(author_id: current_user.id, post_id: @post.id)
    if @like.save
      redirect_to user_post_path(@post.author_id, @post.id), notice: 'Comment was successfully created.'
    else
      render :new, alert: 'like not saved'
    end
  end
end
