class GroupsController < ApplicationController
  
  def show
  	@group = Group.find(params[:id])
  end

  def new
  	@group = Group.new
  end

  def create
  	@group = Group.new(group_params)
  	  if @group.save
  	  	redirect_to(root_url)
  	  else
  	  	render 'new'
  	  end
  end

  def edit
  end

  private

  	def group_params
  		params.require(:group).permit(:name, :link, :image_path, :city, :desc)
  	end

end
