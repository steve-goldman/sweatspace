class SearchController < ApplicationController
  def show
    @navbar.needs_menu_dropdown = false
    @navbar.wide_search = true
    @navbar.back_link = request.referer || root_path
  end
end
