class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, :except => [:index, :show]

  # GET /posts
  # GET /posts.json
  def index
    if signed_in?
      @user = current_user
      @invite = Invite.new
      @message = current_user.sent_messages.build
      @messages = current_user.received_messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
      @sent_messages = current_user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
    end
    @posts = Post.all.paginate :per_page => 2, :page => params[:page], :order => 'created_at DESC'
      respond_to do |format|
        format.html { render :layout => 'blog' }
      end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    if signed_in?
      @user = current_user
      @invite = Invite.new
      @message = current_user.sent_messages.build
      @messages = current_user.received_messages.paginate :per_page => 10, :page => params[:page], :include => :message, :order => "messages.created_at DESC"
      @sent_messages = current_user.sent_messages.paginate :per_page => 10, :page => params[:page], :order => "created_at DESC"
    end
    @post = Post.find(params[:id])
    render :layout => 'blog'
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body, :author_name)
    end

    def authenticate
      redirect_to(root_url) unless current_user.subscriber == "Blogger"
    end
end
