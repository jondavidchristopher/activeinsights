# frozen_string_literal: true

module ActiveInsights
  class RpmController < ApplicationController
    def index
      @minutes =
        ActiveInsights::Request.where(started_at: @date).
        minute_by_minute.select("COUNT(id) AS rpm").select_started_at.
        map { |minute| [minute.started_at.strftime("%-l:%M%P"), minute.rpm] }
    end

    def redirection
      redirect_to rpm_path(params[:date])
    end
  end
end
