class ClassChangesController < ApplicationController
  before_action :find_clazz

  def show
    @clazz = @clazz.decorate
    respond_to do |format|
      format.js
    end
  end

  def cancel
  end

  def delete
  end

  def last_in_repeating_group
  end

  private

  def find_clazz
    @clazz = Clazz.confirmed.find_by id: params[:class_id]
    if @clazz.nil?
      flash[:danger] = "Could not find class"
      redirect_to classes_path
    end
  end
end
