module Admin::V1
  class CategoriesController < ApplicationController
    before_action :load_category, only: %i[show edit update destroy]

    def index
      @categories = Category.all
      render json: { categories: categories.as_json(only: [:id, :name]) }
    end

    def new
      @category = Category.new
      render json: { category: category.as_json(only: [:id, :name]) }
    end

    def create
      @category = Category.new(category_params)
      if @category.save
        render :show, status: :created
        # render json: category, status: :created
      else
        render_error(fields: @category.errors.messages)
        # render json: { errors: category.errors }, status: :unprocessable_entity
      end
    end

    def show
      render json: @category
    end

    def edit
      render json: @category
    end

    def update
      if @category.update(category_params)
        render :show, status: :ok
      else
        render_error(fields: @category.errors.messages)
      end
    end

    def destroy
      if @category.destroy
        head :no_content
      else
        render_error(fields: @category.errors.messages)
      end
    end

    private

    def load_category
      @category = Category.find_by(id: params[:id])
    rescue ActiveRecord::RecordNotFound
      render_error(message: "Categoria não encontrada", status: :not_found) unless @category
    end

    def category_params
      params.require(:category).permit(:name)
    end

    def render_error(fields:)
      render json: { errors: fields }, status: :unprocessable_entity
    end
  end
end
