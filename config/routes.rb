Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :customers
      resources :categories do 
        collection do 
          get :getChildCategoriesOrProducts
        end
      end
      resources :products do
        resources :product_prices
      end
    resources :product_prices
      resources :cities do
        # resources :product_price
      end
    resources :product_price
    resources :admin do
      collection do
        put 'login'
        get 'testMvaayoo'
      end
    end
    end
  end
end
