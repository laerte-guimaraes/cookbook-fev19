class Recipe < ApplicationRecord
  belongs_to :recipe_type

  validates :title, :difficulty, :recipe_type, :cuisine,
    :cook_method, :ingredients, presence: true
  validates :cook_time, numericality: {other_than: 0, message: 'O tempo de preparo não pode ser igual a 0 (zero)!'}
  validates :cook_time, numericality: {greater_than: 0, message: 'O tempo de preparo não pode ser negativo!'}
  
  
  def cook_time_min
    "#{cook_time} minutos"
  end
end
