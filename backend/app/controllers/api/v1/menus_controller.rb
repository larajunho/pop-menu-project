module Api
    module V1
      class MenusController < ApplicationController
        def index
          menus = Menu.all
          render json: menus, include: :menu_items
        end
  
        def show
          menu = Menu.find(params[:id])
          render json: menu, include: :menu_items
        end
      end
    end
  end
  
