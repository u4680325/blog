class CommentsController < ApplicationController
  before_action :set_post

  def create
    if params[:comment][:content].present? && @post.pending?
      if params[:comment][:content].start_with?("/") && params[:comment][:content].length == 2
        case params[:comment][:content][1]
        when "a"
          # Code to execute if /a (achieve)
          if @post.user == Current.user && !@post.votes.empty?
            @post.achieve
            if @post.save
              redirect_to @post, notice: "This post have successfully been achieved."
            end
          end
        when "y"
          # Code to execute if /y (approve)
          if @post.approvers.include?(Current.user.email_address)
            @post.permits << Current.user.email_address
            @post.approvers.delete(Current.user.email_address)
            @post.approve if @post.approvers.empty?
            if @post.save
              redirect_to @post, notice: "You have successfully approved."
            end
          end
        when "n"
          # Code to execute if /n (reject)
          if @post.approvers.include?(Current.user.email_address)
            @post.rejected_by = Current.user.email_address
            @post.approvers.delete(Current.user.email_address)
            @post.reject
            if @post.save
              redirect_to @post, notice: "You have successfully rejected."
            end
          end
        when /\d/
          # Code to execute if /0..9 (vote)
          if @post.voters.include?(Current.user.email_address)
            @post.votes[params[:comment][:content][1].to_i] += 1
            @post.voters.delete(Current.user.email_address)
            if @post.save
              redirect_to @post, notice: "You have successfully voted ##{params[:comment][:content][1]}."
            end
          end
        else
          # Code to execute if no condition matches
        end
      else
        @comment = @post.comments.new params.expect(comment: [ :content ])
        @comment.user = Current.user
        if @comment.save
          redirect_to @post
        end
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params.expect(:post_id))
    raise "Cannot comment without post" if @post.nil?
  end
end
