class RecipesController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @lists = List.all
  end

  def new
    @recipe = Recipe.new
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user
    if @recipe.save
      redirect_to @recipe
      # RecipesMailer.with(recipe_id: @recipe.id).notify_new_recipe
      RecipesMailer.notify_new_recipe(@recipe.id)
    else
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
      render 'new'
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
    @recipe_types = RecipeType.all
    @cuisines = Cuisine.all
  end

  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      redirect_to @recipe      
    else
      @recipe_types = RecipeType.all
      @cuisines = Cuisine.all
      render 'edit'
    end  
  end

  def destroy
    Recipe.find(params[:id]).delete
    redirect_to root_path
  end

  def search
    @recipes = Recipe.where("title like ?", "%#{params[:q]}%")
  end

  def favorite
    @recipe = Recipe.find(params[:id])
    @recipe.favorite = true
    @recipe.save
    redirect_to @recipe
  end

  def unfavorite
    @recipe = Recipe.find(params[:id])
    @recipe.update(favorite: false)
    redirect_to @recipe
  end

  def my_recipes
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def add_list
    @list = List.find(params[:list_id])
    @recipe = Recipe.find(params[:id])
    ListRecipe.create(list: @list, recipe: @recipe)
    redirect_to @recipe
  end

  private

  def recipe_params
    params.require(:recipe).permit(:title, :recipe_type_id, :cuisine_id, :difficulty,
                                   :cook_time, :ingredients, :cook_method, :photo)
  end
end
