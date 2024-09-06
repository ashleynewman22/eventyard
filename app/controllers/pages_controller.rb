# app/controllers/pages_controller.rb
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @cart = current_user.carts.includes(:item) if user_signed_in?
  end

  def about
    
  end
end
