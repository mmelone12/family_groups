class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:id])
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to @post
  end

  private

    def comment_params
      params.require(:comment).permit(:body, :post_id)
    end
end
