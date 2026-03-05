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
              @post.comments.create!(user: Current.user, content: "ACHIEVED!!! /a")
              redirect_to @post, notice: "This post have successfully been achieved."
            end
          end
        when "y"
          # Code to execute if /y (approve)
          if @post.pending_approvers.include?(Current.user.email_address)
            @post.approvers << Current.user.email_address
            @post.pending_approvers.delete(Current.user.email_address)
            @post.approve if @post.pending_approvers.empty?
            if @post.save
              @post.comments.create!(user: Current.user, content: "APPROVED!!! /y")
              redirect_to @post, notice: "You have successfully approved."
            end
          end
        when "n"
          # Code to execute if /n (reject)
          if @post.pending_approvers.include?(Current.user.email_address) || @post.approvers.include?(Current.user.email_address)
            @post.rejected_by = Current.user.email_address
            @post.reject
            if @post.save
              @post.comments.create!(user: Current.user, content: "REJECTED!!! /n")
              redirect_to @post, notice: "You have successfully rejected."
            end
          end
        when /\d/
          # Code to execute if /0..9 (vote)
          if @post.pending_voters.include?(Current.user.email_address)
            @post.with_lock do
              @post.votes[params[:comment][:content][1].to_i] += 1
              @post.pending_voters.delete(Current.user.email_address)
              if @post.save
                redirect_to @post, notice: "You have successfully voted ##{params[:comment][:content][1]}."
              end
            end
          end
        else
          # Code to execute if no condition matches
          redirect_to @post, notice: "#{params[:comment][:content]} is not a command."
        end
      else
        @comment = @post.comments.new params.expect(comment: [ :content ])
        @comment.user = Current.user
        @comment.save
        # if @comment.save
        # @comment.broadcast_append_to @comment.post, target: "comments", partial: "comments/comment"
        # end
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
