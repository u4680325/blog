class PostsController < ApplicationController
  before_action :set_post, only: %i[ edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.where(status: ["pending","approved","rejected"]).reverse
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params.expect(:id))
  end

  # GET /posts/new
  def new
    @post_categories = PostCategory.all
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    if @post.pending?
      @post_categories = PostCategory.all
    else
      raise "Cannot edit non-pending post"
    end
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.approvers = @post.post_category.approvers unless @post.post_category.approvers.empty?
    unless @post.post_category.voters.empty?
      @post.voters = @post.post_category.voters
      @post.votes = [0,0,0,0,0,0,0,0,0,0]
    end
    @post.user = Current.user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        @post_categories = PostCategory.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    if @post.pending?
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post, notice: "Post was successfully updated.", status: :see_other }
          format.json { render :show, status: :ok, location: @post }
        else
          @post_categories = PostCategory.all
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      raise "Cannot update non-pending post"
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    if @post.pending?
      @post.cancel
      respond_to do |format|
        if @post.save
          format.html { redirect_to posts_path, notice: "Post was successfully deleted.", status: :see_other }
          format.json { head :no_content }
        end
      end
    else
      raise "Cannot delete non-pending post"
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params.expect(:id))
    raise "Permission Denied" unless @post.user == Current.user
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.expect(post: [ :title, :body, :post_category_id ])
  end
end
