class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :user

  has_many :recipe_categories

  validates :title, :cook_time, :ingredients, :instructions, presence: true
end
