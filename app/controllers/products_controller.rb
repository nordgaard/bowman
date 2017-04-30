class ProductsController < ApplicationController
# before_action :authenticate_user!, except: [:index]


  def index

    if params[:sort]
      @products = Product.order(params[:sort] => params[:sort_order])
    elsif params[:discount]
      @products = Product.where("price < ?", 100)
    elsif params[:category]
         @products = Category.find_by(name: params[:category]).products
    else
      @products = Product.all
    end
    # render :new
  end

  def show   #shoe is used to return just one, like random example
    if params[:id] == "random"
      @product = Product.all.sample
    else
      @product = Product.find_by(id: params[:id])
    end
  end

  def new
    @product = Product.new 
    # unless current_user && current_user.admin
      # redirect_to "/products"
    # end
  end

  def create
    @product = ProductsControllerroduct.new(name: params[:name], price: params[:price], description: params[:description], make: params[:make], model: params[:model], image_url: params[:image_url],user_id: current_user.id)
    if @product.save #happy path :)
      flash[:success] = "product Created!"
      redirect_to "/products/#{@product.id}"
    else #sad path :(
      render :new
    end
  end

def products_params
  params.require(:user).permit(:avatar)
end




  def edit
    @product = Product.find_by(id: params[:id])
  end

  def update
    #First Way
    # @product = Product.find_by(id: params[:id])
    # @prodcut.assign_attributes(name: params[:name], price: params[:price], color: params[:color], make: params[:make],model: params[:model])
    # @product.save
  
    #Second Way
    # @product = Product.find_by(id: params[:id])
    # @recipe.update(name: params[:name], price: params[:price], color: params[:color], make: params[:make],model: params[:model])

    #Third Way
    @product = Product.find_by(id: params[:id])
    @product.name = params[:name]
    @product.price = params[:price]
    @product.color = params[:color]
    @product.make = params[:make]
    @product.model = params[:model]
    @product.description = params[:description]
    @product.in_stock = params[:in_stock]
    @product.save
    flash[:success] = "Product Updated"
    redirect_to "/products/#{@product.id}"
  end

 

  def search
    search_term = params[:user_search]
    @products = Product.where("name LIKE ? OR description LIKE ?", "%#{search_term}%", "%#{search_term}%")
   render :index
  end
end



