class OrdersController < ApplicationController
  before_action :set_order

  def show
  end

  private

  def set_order
    @order = Order.find_by!(token: params[:token])
  end
end
