class ItemsController < ApplicationController
  # before_action :set_item, only: [:show, :new, :create, :destroy]

  def index
    @items = Item.all
  end

  def show
    # @item = Item.find(items_params)
    # @item = @item.name
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new # need to use simple_form_for for user to create new item rental
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      redirect_to @item
      # redirect_to item_path(@item)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @item = Item.find(params[:id])
    # @item = Item.find(items_params)
    @item.destroy
    redirect_to items_path, status: :see_other
    # redirect_to item_path(item), status: :see_other
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :category, :description, :photo)
  end

  # def set_item
  #   @item = Item.find(params[:id])
  # end
end
