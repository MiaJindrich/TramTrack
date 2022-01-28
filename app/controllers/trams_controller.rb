class TramsController < ApplicationController
  def index
    @trams = Route.all
  end

  def tram_select
    redirect_to action: :show_order, id: params[:id]
  end

  def show_order
    @trams = Route.all
    @tram = Route.find(params[:id])
  end
end
