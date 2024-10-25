class DashboardsController < ApplicationController
  layout "fullscreen"

  def daily_overview
    @animals = Animal.active.includes(:diet_entries).order(:species_id).to_a
    @today = Date.today
    @today_name = @today.strftime('%A')
    @mealtime = "Breakfast"
    @header_text = "#{@mealtime} Feed Schedule for: #{@today_name}, #{@today.strftime('%D')}"
  end
end