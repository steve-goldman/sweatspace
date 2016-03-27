class RobotsController < ApplicationController
  def show
    render file: Rails.application.root.join("public", "#{Rails.env}_robots.txt"),
           layout: false,
           content_type: "text/plain"
  end
end
