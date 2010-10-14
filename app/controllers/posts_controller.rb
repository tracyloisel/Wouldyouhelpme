class PostsController < ApplicationController
  before_filter :login_required
  
  layout  "layout"
  
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.find(:all, :order => "position, created_at DESC", :include => [:assets, :comments], :conditions => "archive=0")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:post_id])
    
    if request.xhr? then
      render :action => "edit.rjs"
    end
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = @current_user.posts.build(params[:post])
    if @post.save then
      Feed.create_post(@post)
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post]) then
        Feed.update_post(@post)
        format.js { render :action => "update.rjs" } if request.xhr?
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = @current_user.posts.find(params[:post])
    if @post then
      Feed.destroy_post(@post)
      @post.destroy
    end
  end
  
  def archive
    @post = Post.find(params[:post])
    
    if @post then
      @post.move_to_archive
      Feed.archive_post(@post)      
    end
  end
  
  def send_by_email
    @post = Post.find(params[:post_id])
    Delayed::Job.enqueue(DelayedJob::NotifyPost.new(@post.id))
  end
  
  def sort_posts
    params[:posts_list].each_with_index do |id, index|
      Post.update_all(['position=?', index+1], ['id=?', id])
    end

    Feed.sort_posts(@current_user)
    render :nothing => true
  end
end
