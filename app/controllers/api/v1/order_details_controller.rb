class Api::V1::OrderDetailsController < ApplicationController
    before_action :set_user
    before_action :set_order
    before_action :set_order_detail, only: [:show, :update, :destroy]

    def index
        @order_details = @order.order_details.order(created_at: :desc)

        render json: { message: "success", data: @order_details }
    end

    def show 
        render json: @order_detail
    end

    def create
        @order_detail = @order.order_details.new(order_detail_params)

        if @order_detail.save
            render json: @order_detail, status: :created
        else
            render json: @order_detail.errors, status: :unprocessable_entity
        end    
    end

    def update
        if @order_detail.update(order_detail_params)
            render json: @order_detail, status: :ok
        else
            render json: @order_detail.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @order_detail.destroy

        render json: { message: "Information deleted."}, status: :ok
    end

    private

    def set_user
        @user = User.find(params[:user_id])
    rescue ActiveRecord::RecordNotFound
        render json: { error: "User not found"}, status: :not_found
    end

    def set_order
        @order = @user.orders.find(params[:order_id])
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Order not found"}, status: :not_found
    end

    def set_order_detail
        @order_detail = @order.order_details.find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: { error: "Information not found"}, status: :not_found
    end
        
    def order_detail_params
        params.require(:order_detail).permit(:item, :quantity, :address)
    end
end