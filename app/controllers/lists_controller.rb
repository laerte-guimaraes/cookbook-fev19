class ListsController < ApplicationController
  
  def index
    @lists = List.where(user: current_user)
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(params.require(:list).permit(:name))
    @list.user = current_user
    @list.save!
    redirect_to lists_path
  end

end