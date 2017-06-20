require 'pry'
class CartsController < ApplicationController

	def show
		@cart = Cart.find_by_id(params[:id])
	end

	def checkout
		@cart = Cart.find_by_id(params[:id])
		
		@cart.checkout
	
		current_user.remove_cart
		redirect_to cart_path(@cart)
	end

end
