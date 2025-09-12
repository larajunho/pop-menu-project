Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :menus, only: [:index, :show] do
        resources :menu_items, only: [:index, :show]
      end
    end
  end
end

