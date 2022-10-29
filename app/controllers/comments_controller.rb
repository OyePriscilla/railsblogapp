class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post_id = params[:post_id]

    if @comment.save
      flash[:success] = 'Comment added successfully!'
      redirect_to user_posts_path(current_user, @post)
    else
      flash.now[:error] = 'comment creation failed!'
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
