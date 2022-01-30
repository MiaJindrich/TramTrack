Rails.application.routes.draw do
  root "trams#index"

  get "/trams", to: "trams#index"
  post "/trams", to: "trams#tram_select"
  get "/trams/:route_id", to: "trams#show_order"
  post "/trams/:route_id", to: "trams#order_select"
  get "/trams/:route_id/:trip_id", to: "trams#time"
  post "/trams/:route_id/:trip_id", to: "trams#time_select"
  get "/trams/:route_id/:trip_id/:time", to: "trams#location"

end
