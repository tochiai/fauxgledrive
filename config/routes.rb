Fauxgledrive::Application.routes.draw do
  resources :user_files, only: [:show, :destroy, :index]

  post "/upload", to: "user_files#upload"
end
