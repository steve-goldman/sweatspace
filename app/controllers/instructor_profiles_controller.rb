class InstructorProfilesController < ApplicationController
  before_action :user_signed_in, except: :show
  before_action :user_does_not_have_profile, only: [:new, :create, :welcome]
  before_action :user_has_profile, except: [:show, :new, :create, :welcome]
  before_action :find_instructor_profile, only: [:edit, :update, :destroy]
  before_action :owns_instructor_profile, only: [:edit, :update, :destroy]
  before_action :find_instructor_profile_by_name, only: :show

  def show
    @classes_by_date = classes_by_date
    @date_range = date_range
    @presenter = InstructorClassesPresenter.new classes_by_date, date_range
    NavbarConfig.instance.new_class_button = owner?
    @instructor_profile = @instructor_profile.decorate
  end

  def new
    @instructor_profile = InstructorProfile.new profile_path: current_user.name.downcase.gsub(" ", "-")
  end

  def edit
  end

  def create
    @instructor_profile = current_user.build_instructor_profile create_params
    if @instructor_profile.save
      redirect_to profile_path(@instructor_profile.profile_path)
    else
      render :new
    end
  end

  def update
    unless @instructor_profile.update_attributes create_params
      flash[:danger] = @instructor_profile.errors.full_messages.first
    end
    redirect_to profile_path(@instructor_profile.profile_path)
  end

  def welcome
  end

  private

  def assert_instructor_profile
    if @instructor_profile.nil?
      flash[:danger] = "Unable to find instructor profile"
      redirect_to root_path
    end
  end

  def find_instructor_profile
    @instructor_profile = InstructorProfile.find_by id: params[:id]
    assert_instructor_profile
  end

  def find_instructor_profile_by_name
    @instructor_profile = InstructorProfile.find_by profile_path: params[:id]
    assert_instructor_profile
  end

  def owner?
    user_signed_in? && current_user.id == @instructor_profile.user_id
  end

  def owns_instructor_profile
    unless owner?
      flash[:danger] = "Unauthorized access"
      redirect_to root_path
    end
  end

  def create_params
    if params.has_key? :instructor_profile
      params.require(:instructor_profile).permit(InstructorProfile::PERMITTED_PARAMS)
    else
      {}
    end
  end

  def classes_by_date
    @classes_by_date ||=
      begin
        classes.each_with_object({}) do |clazz, classes_by_date|
          (classes_by_date[clazz.date] ||= []).push clazz
        end
      end
  end

  def classes
    @classes ||= @instructor_profile.classes.confirmed.includes([:studio, :class_template])
      .order(timestamp: :asc)
      .where(timestamp: date_range.range).decorate
  end

  def date_range
    @date_range ||= DateRange.new current_user, params[:start_date]
  end
end
