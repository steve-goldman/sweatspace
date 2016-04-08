class SearchController < ApplicationController
  before_action :find_query

  def show
    @instructor_profiles = Elasticsearch::Model.search("*#{@query}*").records
  end

  private

  def find_query
    @query = params[:query]
  end
end
