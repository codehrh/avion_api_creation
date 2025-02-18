class Api::V1::OrdersController < ApplicationController
    before_action :set_user
    before_action :set_order, only: [:show, :update, :destroy]

    def index
        @orders = @user.orders.order(created_at: :desc)

        render json: { message: "success", data: @orders }
    end

    def show
        render json: @order
    end

    def create
        @order = @user.orders.new(order_params)

        if @order.save
            render json: @order, status: :created
        else
            render json: @order.errors, status: :unprocessable_entity
        end
    end

    def update
        if @order.update(order_params)
            render json: @order, status: :ok
        else 
            render json @order.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @order.destroy
        
        render json: { message: "Order deleted."}, status: :ok
    rescue ActiveRecord::InvalidForeignKey
        render json: { message: "Cannot be deleted. Package under the order still exists."}
    end

    private

    def set_user
        @user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound
        render json: { error: "User not found"}, status: :not_found
    end

    def set_order
        @order = @user.orders.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Order not found"}, status: :not_found
    end

    def order_params
        # strong parameters / allow edit or create
        params.require(:order).permit(:order_number)
    end
end