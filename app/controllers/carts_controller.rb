class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :destroy]
  before_action :set_item, only: [:new, :create]

  def index
    @carts = Cart.all.includes(:item)
    @total_price = @carts.sum(&:total_price)

  end

  def show
    authorize @cart
  end

  def new
    @cart = Cart.new
  end

  def create
    @cart = Cart.new(cart_params)
    @cart.item = @item
    @cart.user = current_user
    @cart.status = "pending"
    if @cart.save
      redirect_to carts_path, notice: 'Item added to cart successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def accept
    set_cart
    if @cart.update(status: "accepted")
      redirect_to carts_path, notice: 'Booking accepted!'
    else
      redirect_to carts_path, alert: 'Failed to accept booking.'
    end
  end

  def decline
    set_cart
    if @cart.update(status: "declined")
      redirect_to carts_path, notice: 'Booking declined'
    else
      redirect_to carts_path, alert: 'Failed to decline booking.'
    end
  end

 
  def destroy
    set_cart
    if @cart.destroy
    redirect_to carts_path, notice: 'Item removed from cart.'
    else
    redirect_to carts_path, alert: 'Failed to remove item from cart'
    end
  end

  def remove_all
    current_user.carts.destroy_all
    redirect_to carts_path, notice: 'All items removed from cart.'
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
