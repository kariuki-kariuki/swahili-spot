class OrdersController < ApplicationController
  # skip_before_action :authorize, only: [:create, :index]
  def index
    product = Order.where(user_id: session[:user_id]).order("created_at DESC")
    render json: product, include: [:product, :user], status: :ok
  end

  def show
    product = Order.find(params[:id])
    render json: product, include: [:product, :user], status: :ok
  end

  def create
    product = Order.create(user_id: session[:user_id], product_id: params[:product_id], quantity: 1, status: "pending")
    render json: product, status: :ok
  end

  def update
    order = Order.find_by(id: params[:id])
    # byebug
    order.update(order_params)
    render json: order, status: :ok
  end

  def destroy
    order = Order.find_by(id: params[:id])
    order.destroy
    head :no_content
  end


  private

  def order_params
    params.permit(:id, :user_id, :product_id, :quantity)
  end

end
