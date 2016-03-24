class GotItsController < ApplicationController
  before_action :has_key

  def create
    unless @key.nil?
      cookies.permanent[@key] = Time.current
    end
  end

  private

  def has_key
    @key = params[:key]
  end
end
