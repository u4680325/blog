class CommentsController < ApplicationController
  before_action :set_post

  def create
    if params[:comment][:content].present?
      @comment = @post.comments.new params.expect(comment: [ :content ])
      @comment.user = Current.user
      @comment.save
      redirect_to @post
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params.expect(:post_id))
    raise "Cannot comment without post" if @post.nil?
  end
end
