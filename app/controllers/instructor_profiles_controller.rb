class InstructorProfilesController < ApplicationController
  before_action :find_instructor_profile, only: [:edit, :update, :destroy]
  before_action :owns_instructor_profile, only: [:edit, :update, :destroy]
  before_action :find_instructor_profile_by_name, only: :show

  def show
    @classes = @instructor_profile.classes.confirmed.order(timestamp: :asc).decorate
    @instructor_profile = @instructor_profile.decorate
  end

  def new
    @instructor_profile = InstructorProfile.new profile_path: current_user.nickname
  end

  def edit
  end

  def create
    @instructor_profile = current_user.build_instructor_profile create_params
    if @instructor_profile.save
      flash[:success] = "Instructor profile created"
      redirect_to root_path
    else
      render :new
    end
  end

  def update
    if @instructor_profile.update_attributes create_params
      flash[:success] = "Instructor profile saved"
      redirect_to root_path
    else
      render :edit
    end      
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

  def owns_instructor_profile
    unless current_user.id == @instructor_profile.user_id
      flash[:danger] = "Unauthorized access"
      redirect_to root_path
    end
  end

  def create_params
    params.require(:instructor_profile).permit(InstructorProfile::PERMITTED_PARAMS)
  end
end
