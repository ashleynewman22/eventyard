class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :destroy]
  before_action :set_item, only: [:new, :create]

  def index
    @carts = current_user.carts.includes(:item)
  end

  def show
    authorize @cart
  end

  def new
    @cart = Cart.new
  end

  def total_price
    item.price * (end_date - start_date).to_i
  end

  def create
    @cart = Cart.new(cart_params)
    @cart.item = @item
    @cart.user = current_user
    @cart.status = "pending"
    if @cart.save
      redirect_to carts_path, notice: 'Cart created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def accept
    @cart = Cart.find(params[:id])
    @cart.status = "accepted"
    redirect_to carts_path, notice: 'Booking accepted!'
  end

  def decline
    @cart = Cart.find(params[:id])
    @cart.status = "declined"
    redirect_to carts_path, notice: 'Booking declined!'
  end

  def dashboard
    @pending_carts = Cart.where(status: "pending")
  end

  def destroy
    @cart.destroy
    redirect_to carts_path, notice: 'Cart removed.'
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end


  def set_item
    @item = Item.find(params[:item_id])
  end

  def cart_params
    params.require(:cart).permit(:item_id, :start_date, :end_date)
  end
end
