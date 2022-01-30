Rails.application.routes.draw do
  root "trams#index"

  get "/trams", to: "trams#index"
  post "/tram", to: "trams#tram_select"
  get "/tram/:route_id", to: "trams#show_order"
  post "/tram/:route_id/order", to: "trams#order_select"
  get "tram/:route_id/order/:trip_id", to: "trams#location"

end
