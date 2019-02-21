class RecipeTypesController < ApplicationController

  def new
    @recipe_type = RecipeType.new
  end

  def create
    @recipe_type = RecipeType.new(params.require(:recipe_type).permit(:name))
    if @recipe_type.save
      redirect_to @recipe_type
    else
      render :new
    end
  end

  def show
    @recipe_type = RecipeType.find(params[:id])
  end

end