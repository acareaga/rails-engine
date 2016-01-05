Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
        resources :merchants,     only: [:index, :show, :find], defaults: { format: :json }
        resources :customers,     only: [:index, :show, :find], defaults: { format: :json }
        resources :items,         only: [:index, :show, :find], defaults: { format: :json }
        resources :invoices,      only: [:index, :show, :find], defaults: { format: :json }
        resources :invoice_items, only: [:index, :show, :find], defaults: { format: :json }
        resources :transactions,  only: [:index, :show, :find], defaults: { format: :json }
    end
  end
end
