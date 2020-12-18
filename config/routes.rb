Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/revenue', to: 'merchants/intelligence#revenue_between_dates'
      namespace :merchants do
        get '/:id/items', to: 'items#index'
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
        get '/most_revenue', to: 'intelligence#most_revenue'
        get '/most_items', to: 'intelligence#most_items'
        get '/:id/revenue', to: 'intelligence#revenue'
      end

      namespace :items do
        get '/:id/merchants', to: 'merchants#show'
        get '/find_all', to: 'search#index'
        get '/find', to: 'search#show'
      end
      resources :items
      resources :merchants
    end
  end
end
