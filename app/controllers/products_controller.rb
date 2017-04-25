class ProductsController < ApplicationController

	def show
		@product = Product.find_by(id: params[:id])
		render :show
	end

	def index
		@products = Product.all
		render :index
	end

	def create
		product = Product.create(name: params[:name], description: params[:description])
		redirect_to product
	end



end
