class RecipesMailer < ApplicationMailer

  def notify_new_recipe(recipe_id)
    @recipe = Recipe.find(recipe_id)
    mail(
      to: 'admin@cookbook.com',
      subject: "Receita (#{@recipe.title}) criada com sucesso!"
      )
  end

end