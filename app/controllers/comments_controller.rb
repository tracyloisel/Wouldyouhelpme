class CommentsController < ApplicationController
  before_filter :login_required
  
  layout  "public"
  
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment  = @current_user.comments.create(params[:comment])
    
    if @comment.save then
      @post = @comment.post
      Feed.create_comment(@comment)
      Delayed::Job.enqueue(DelayedJob::MailNewComment.new(@comment.id))
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = @current_user.comments.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = @current_user.comments.find(params[:id])
    
    if @comment then
      Feed.destroy_comment(@comment)
      @comment.destroy
    end
  end
end
