class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"]
  def index
    @categories = Category.order(:id).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: "Category created!"
    elsif 
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end
  
end