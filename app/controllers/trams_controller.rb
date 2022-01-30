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
    @trips = Trip.get_todays_trips(params[:route_id])
  end

  def order_select
    redirect_to action: :time, route_id: params[:route_id], trip_id: params[:trip_id]
  end

  def time
    @trams = Route.all
    @tram = Route.find(params[:route_id])
    @trips = Trip.get_todays_trips(params[:route_id])
    @trip = Trip.find(params[:trip_id])
  end

  def time_select
    time_str = parse_time_parameter(params[:time])
    redirect_to action: :location, route_id: params[:route_id], trip_id: params[:trip_id], time: time_str
  end

  def location
    @trams = Route.all
    @tram = Route.find(params[:route_id])
    @trips = Trip.get_todays_trips(params[:route_id])
    @trip = Trip.find(params[:trip_id])
    @time_hod, @time_min = params[:time].split(":")
  end

  def parse_time_parameter(time)
    time["time_select(4i)"] + ":" + time["time_select(5i)"]
  end
end
