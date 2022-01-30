class TramsController < ApplicationController
  def index
    @trams = Route.all
  end

  def tram_select
    redirect_to action: :show_order, route_id: params[:route_id]
  end

  def show_order
    @trams = Route.all
    @tram = Route.find(params[:route_id])
    @trips = Trip.where("route_id = ?", params[:route_id])
  end

  def order_select
    redirect_to action: :location, route_id: params[:route_id], trip_id: params[:trip_id]
  end

  def location

  end
end
