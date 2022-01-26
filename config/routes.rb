Rails.application.routes.draw do
  root "trams#index"

  get "/trams", to: "trams#index"

end
