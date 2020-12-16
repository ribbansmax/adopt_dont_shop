Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "welcome#index"

  get "/shelters", to: "shelters#index"
  get "/shelters/new", to: "shelters#new"
  get "/shelters/:id", to: "shelters#show"
  delete "/shelters/:id", to: "shelters#destroy"
  post "/shelters", to: "shelters#create"
  get "/shelters/:id/edit", to: "shelters#edit"
  patch "/shelters/:id", to: "shelters#update"


  get "/pets", to: "pets#index"
  get "/pets/:id", to: "pets#show", as: 'pet'
  get "/pets/:id/edit", to: "pets#edit"
  patch "/pets/:id", to: "pets#update"
  delete "/pets/:id", to: "pets#destroy"

  get "/shelters/:shelter_id/pets", to: "shelter_pets#index"
  get "/shelters/:shelter_id/pets/new", to: "shelter_pets#new"
  post "/shelters/:shelter_id/pets", to: "shelter_pets#create"
  get "/shelters/:id/pets/:id", to: "pets#show"

  # get "/applications", to: "applications#index", as: 'apps'
  get "/applications/new", to: "applications#new", as: 'new_app'
  get "/applications/:id", to: "applications#show", as: 'show_app'
  post '/applications', to: 'applications#create', as: 'create_app'
  patch "/applications/:id", to: 'applications#update', as: 'update_app'

  resources :adoptions, only: [:create, :update]

  namespace :admin do
    resources :applications, only: [:show]
    # resources :shelters, only: [:index, :show]
  end

end
