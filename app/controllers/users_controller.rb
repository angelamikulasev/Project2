class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
    @user = User.new user_params
 
    if @user.save
      # Tell the UserMailer to send a welcome email after save
      UserMailer.welcome_email(@user).deliver
      # create login session
      session[:user_id] = @user.id
			# Merge in an existing cart if the user has one.
			if session[:cart_id]
				cart = Cart.find_by :id => session[:cart_id]
				
				# If the cart is missing we'll create a new one for them.
				unless cart.present?
					cart = Cart.create
					session[:cart_id] = cart.id
				end

				cart.user_id = @user.id
				cart.save
			end
    	redirect_to root_path
    else
    	render :new
    end
	end

	def edit
		@user = @current_user
	end

	def update
		@user = @current_user
		if @user.update user_params # Check that validations are met.
			redirect_to @user
		else
			render :edit
		end
	end

	def index
		@users = User.all
	end

	def show
		@user = User.find params[:id]
	end

	private

	def user_params
		 params.require(:user).permit(:firstname, :lastname, :email, :email_confirmation, :password, :password_confirmation)
	end
end