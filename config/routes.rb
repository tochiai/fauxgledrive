Fauxgledrive::Application.routes.draw do
  resources :user_files

  post "/upload", to: "user_files#upload"
end
