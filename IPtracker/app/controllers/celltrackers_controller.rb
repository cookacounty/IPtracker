class CelltrackersController < ApplicationController
  before_action :signed_in_user

  def create
    @cdscell = Cdscell.find(params[:celltracker][:tracked_id])
    current_user.track!(@cdscell)
    respond_to do |format|
      format.html { redirect_to @cdscell }
      format.js
    end
  end

  def destroy
    @cdscell = Celltracker.find(params[:id]).tracked
    current_user.untrack!(@cdscell)
    respond_to do |format|
      format.html { redirect_to @cdscell }
      format.js
    end
  end
end