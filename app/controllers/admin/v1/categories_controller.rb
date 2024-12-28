module Admin::V1
  class CategoriesController < ApplicationController
    before_action :load_category, only: [:show, :update, :destroy]

    def index
      @loading_service = Admin::ModelLoadingService.new(Category.all, searchable_params)
      @loading_service.call
    end

    def new
      @category = Category.new
      render json: { category: category.as_json(only: [:id, :name]) }
    end

    def create
      category = Category.new(category_params) # Inicializa a nova categoria com os parâmetros

      if category.save
        render json: { category: category.slice(:id, :name) }, status: :created
      else
        render json: { errors: { fields: category.errors } }, status: :unprocessable_entity
      end
    end

    def show; end

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

    def searchable_params
      params.permit({ search: :name }, { order: {} }, :page, :length)
    end

    def category_params
      params.require(:category).permit(:name) # Ajuste os atributos conforme necessário
    end

    def render_error(fields:)
      render json: { errors: { fields: fields } }, status: :unprocessable_entity
    end
  end
end
