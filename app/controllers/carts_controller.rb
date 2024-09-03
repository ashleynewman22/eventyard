class CartController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :destroy, :checkout, :confirm]

  def index
    @carts = Cart.joins(:item).where(items: { user_id: current_user.id })
  end

  def show
  end

  def new
    @cart = Cart.new
  end

  def create
    @cart = current_user.carts.build(cart_params)
    if @cart.save
      redirect_to @cart, notice: 'Cart created successfully.'
    else
      redirect_back(fallback_location: items_path)
    end
  end

  def accept
    @booking.update_attribute(:accepted, true)
    redirect_to carts_path
  end

  def decline
    @booking.update_attribute(:accepted, false)
    redirect_to carts_path
  end

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
      # Notify the item owner about the pending approval

      notify_item_owner
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

  def notify_item_owner
    # Implement notification logic here
  end
end
