class RecipeCategoriesController < ApplicationController
  before_action :authenticate_user!, only: %i[create new]
  def new
    @recipe_category = RecipeCategory.new
  end

  def create
    @recipe_category = current_user.recipe_categories.build(recipe_category_params)
    if @recipe_category.save
      flash[:notice] = t('.success')
      redirect_to @recipe_category
    else
      @recipe_category = RecipeCategory.new
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  def show
    @recipe_category = RecipeCategory.find(params[:id])
    @recipes_in_category = Recipe.where(recipe_categories: @recipe_category)
    @recipes_out_category = Recipe.where()
  end

  private

  def recipe_category_params
    params.require(:recipe_category).permit(:name)
  end
end