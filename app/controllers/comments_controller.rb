class CommentsController < ApplicationController

  # authenticate_user! ejecuta acción solo si sesión existe
  before_filter :authenticate_user!

     
  def create
   		@site = Site.find(params[:site_id])
  		@comment = @site.comments.create(params[:comment])
  		@comment.user_id = current_user.id
  		
  		respond_to do |format|
   		if @comment.save
       		format.html { redirect_to @site, notice: 'Comentario creado' }
       		format.json { head :no_content }
    	else
       		format.html { render action: "edit" }
       		format.json { render json: @comment.errors, status: :unprocessable_entity }
    	end
   	end
  end
  def destroy
    @site = Site.find(params[:site_id])
    @comment = @site.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to site_path(@site) }
      format.json { head :no_content }
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
	 @site = Site.find(params[:site_id])
	 @comment = @site.comments.find(params[:id])

	 respond_to do |format|
		  if @comment.update_attributes(params[:comment])
		  	format.html { redirect_to @site, notice: 'Comentario actualizado' }
		  	format.json { head :no_content }
		  else
			 format.html { render action: "edit" }
		  	format.json { render json: @comment.errors, status: :unprocessable_entity }
		  end
	  end
  end

  def edit
        @site = Site.find(params[:site_id])
        @comment = @site.comments.find(params[:id])
  end
  def index
        @user = User.find(params[:user_id])
    end
end
