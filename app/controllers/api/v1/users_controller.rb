class Api::V1::UsersController < ApplicationController
	before_action :set_user, only: [:show, :update, :destroy]
	def index
		@users = User.order(created_at: :desc)

		render json: { message: "success", data: @users }
	end

	def show
		render json: @user
	end

	def create
		@user = User.new(user_params)

		if @user.save
				redirect_to api_v1_users_path
		else
				render json: @user.errors, status: :unprocessable_entity
		end
	end

	def update
		if @user.update(user_params)
			render json: @user, status: :ok
		else
			render json: @user.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@user.destroy!
			
		redirect_to api_v1_users_path
	rescue ActiveRecord::InvalidForeignKey
		render json: { message: "Cannot be deleted. An order for the user still exists."}
	end

	private

	def user_params
		# strong parameters / allow edit or create
		params.require(:user).permit(:first_name, :last_name, :phone_number)
	end

	def set_user
		@user = User.find(params[:id])
	rescue ActiveRecord::RecordNotFound
		render json: { error: "User not found" }, status: :not_found
	end
end
