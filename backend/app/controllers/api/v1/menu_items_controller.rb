module Api
    module V1
      class MenuItemsController < ApplicationController
        def index
          menu = Menu.find(params[:menu_id])
          render json: menu.menu_items
        end
  
        def show
          menu_item = MenuItem.find(params[:id])
          render json: menu_item
        end
      end
    end
  end
  
