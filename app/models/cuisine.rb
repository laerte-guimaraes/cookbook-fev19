class Cuisine < ApplicationRecord

  validates :name, presence: {message: 'Você deve informar o nome da cozinha'}
  validates :name, uniqueness: {message: 'Você não pode repetir o nome de uma cozinha'}

end
