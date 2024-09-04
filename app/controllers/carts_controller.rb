class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :destroy, :checkout, :confirm]

  def index
    @carts = current_user.carts
  end

  def show
    cart = cart.find(params[:id])
  end

  def new
    @cart = cart.new
  end

  def create
    @cart = current_user.carts.build(cart_params)
    if @cart.save
      redirect_to @cart, notice: 'Cart created successfully.'
    else
      render :new
    end
  end

  # def accept
  #   @booking.update_attribute(:accepted, true)
  #   redirect_to carts_path
  # end

  # def decline
  #   @booking.update_attribute(:accepted, false)
  #   redirect_to carts_path
  # end

  def destroy
    @cart.destroy
    redirect_to carts_path, notice: 'Cart removed.'
  end

  def add_to_cart
    @item = Item.find(params[:item_id])
    @cart = current_user.carts.find_or_create_by(status: 'open')
    @cart.cart_items.create(item: @item)
    redirect_to @cart, notice: 'Item added to cart successfully.'
  end

  def checkout
    @item.user
  end

  def confirm
    if @cart.update(cart_params)
      @cart.update(status: 'pending_approval')
        redirect_to @cart, notice: 'Order submitted for approval. Cash on delivery.'
    else
      render :checkout
    end
  end

  private

  def set_cart
    @cart = current_user.carts.find(params[:id])
  end

  def cart_params
    params.require(:cart).permit(:item_id, :cart_date)
  end
end
