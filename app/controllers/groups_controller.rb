class GroupsController < ApplicationController
  
  def show
  	@group = Group.find(params[:id])
  end

  def new
  	@group = Group.new
  end

  def create
  	@group = Group.new(group_params)
    @group.save
    current_user.group_follow!(@group)
  	respond_to do |format|
      format.html { redirect_to(root_url) }
      format.js 
    end
  end

  def edit
  end

  private

  	def group_params
  		params.require(:group).permit(:name, :link, :image_path, :city, :desc, :group_id, :user_id, :address, :uploader_image)
  	end

end