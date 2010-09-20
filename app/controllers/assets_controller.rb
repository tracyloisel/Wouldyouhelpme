class AssetsController < ApplicationController
  # GET /assets
  # GET /assets.xml
  def index
    @assets = Assets.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assets }
    end
  end

  # GET /assets/1
  # GET /assets/1.xml
  def show
    @assets = Assets.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assets }
    end
  end

  # GET /assets/new
  # GET /assets/new.xml
  def new
    @assets = Assets.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assets }
    end
  end

  # GET /assets/1/edit
  def edit
    @assets = Assets.find(params[:id])
  end

  # POST /assets
  # POST /assets.xml
  def create
    @assets = Assets.new(params[:assets])

    respond_to do |format|
      if @assets.save
        flash[:notice] = 'Assets was successfully created.'
        format.html { redirect_to(@assets) }
        format.xml  { render :xml => @assets, :status => :created, :location => @assets }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assets.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /assets/1
  # PUT /assets/1.xml
  def update
    @assets = Assets.find(params[:id])

    respond_to do |format|
      if @assets.update_attributes(params[:assets])
        flash[:notice] = 'Assets was successfully updated.'
        format.html { redirect_to(@assets) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assets.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.xml
  def destroy
    @assets = Assets.find(params[:id])
    @assets.destroy

    respond_to do |format|
      format.html { redirect_to(assets_url) }
      format.xml  { head :ok }
    end
  end
  
  def upload
    @asset  = Asset.create! params[:asset]
    
    if @asset.errors.empty? then
      @post = Post.create(params[:post])
      
      if @post.errors.empty? then
        @asset.update_attributes(:post_id => @post.id, :email => @post.email, :user_id => @post.user_id)
      end
    end
    
    respond_to do |_format|
      _format.js do
        responds_to_parent do
          render :action => :upload
        end
      end
    end
  end
end
