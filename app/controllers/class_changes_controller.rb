class ClassChangesController < ApplicationController
  before_action :user_signed_in
  before_action :find_clazz
  before_action :owns_clazz
  before_action :not_in_the_past
  before_action :not_canceled, only: :cancel
  before_action :canceled, only: :uncancel
  before_action :not_substituted, only: :substitute
  before_action :substituted, only: :unsubstitute


  def cancel
    if @clazz.update_attributes canceled: true
      flash[:success] = "Class canceled"
    else
      flash[:danger] = "Unable to cancel class"
    end
    redirect_to class_path(@clazz)
  end

  def uncancel
    if @clazz.update_attributes canceled: false
      flash[:success] = "Class un-canceled"
    else
      flash[:danger] = "Unable to un-cancel class"
    end
    redirect_to class_path(@clazz)
  end

  def substitute
    if @clazz.update_attributes substituted: true
      flash[:success] = "Class substituted"
    else
      flash[:danger] = "Unable to substitute class"
    end
    redirect_to class_path(@clazz)
  end

  def unsubstitute
    if @clazz.update_attributes substituted: false
      flash[:success] = "Class un-substituted"
    else
      flash[:danger] = "Unable to un-substitute class"
    end
    redirect_to class_path(@clazz)
  end

  def delete
    if @clazz.destroy
      flash[:success] = "Class deleted"
    else
      flash[:danger] = "Unable to delete class"
    end
    redirect_to profile_path(@clazz.instructor_profile.profile_path)
  end

  def delete_and_future_weeks
    if @clazz.recurring_class.delete_from! @clazz
      flash[:success] = "Recurring class deleted"
    else
      flash[:danger] = "Unable to delete recurring class"
    end
    redirect_to profile_path(@clazz.instructor_profile.profile_path)
  end

  private

  def find_clazz
    @clazz = Clazz.confirmed.find_by id: params[:class_id]
    if @clazz.nil?
      flash[:danger] = "Could not find class"
      redirect_to profile_path(current_user.instructor_profile.profile_path)
    end
  end

  def owns_clazz
    unless current_user.id == @clazz.instructor_profile.user_id
      flash[:danger] = "Unauthorized access"
      redirect_to root_path
    end
  end

  def not_canceled
    if @clazz.canceled?
      flash[:danger] = "Class already canceled"
      redirect_to root_path
    end
  end

  def canceled
    unless @clazz.canceled?
      flash[:danger] = "Class not canceled"
      redirect_to root_path
    end
  end

  def not_substituted
    if @clazz.substituted?
      flash[:danger] = "Class already substituted"
      redirect_to root_path
    end
  end

  def substituted
    unless @clazz.substituted?
      flash[:danger] = "Class not substituted"
      redirect_to root_path
    end
  end

  def not_in_the_past
    if @clazz.in_the_past?
      flash[:danger] = "Class in the past"
      redirect_to root_path
    end
  end
end
