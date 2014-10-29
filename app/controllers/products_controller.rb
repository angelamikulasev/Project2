class ProductsController < ApplicationController
	# skip_before_filter :verify_authenticity_token
	before_action :setup_cart

	def index
		@products = Product.all
	end

	def show
		@product = Product.find params[:id]
	end

	private

	def product_params
		params.require(:product).permit(:name, :description, :price, :brand, :size, :image)
	end

	def setup_cart
		if @current_user.present?
			@cart = @current_user.cart
		elsif session[:cart_id].present?
			@cart = Cart.find_by :id => session[:cart_id]
			session[:cart_id] = nil unless @cart.present?
		else
			@cart = Cart.create
			session[:cart_id] = @cart.id
		end
	end
end