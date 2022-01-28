Rails.application.routes.draw do
  root "trams#index"

  get "/trams", to: "trams#index"
  post "/tram", to: "trams#tram_select"
  get "/tram/:id", to: "trams#show_order"

end
