class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.new params.expect(comment: [ :content ])
    @comment.user = Current.user
    @comment.save
    redirect_to @post
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:post_id])
  end
end
