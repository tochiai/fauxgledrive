Fauxgledrive::Application.routes.draw do
  resources :user_files, except: :edit

  post "/upload", to: "user_files#upload"
end
