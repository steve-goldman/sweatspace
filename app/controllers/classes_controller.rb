class ClassesController < ApplicationController
  before_action :find_class, only: [:edit, :update]
  before_action :owns_class, only: [:edit, :update]

  def index
    @clazzes = profile.classes.decorate
  end

  def new
    if profile.class_templates.empty?
      flash[:info] = "You must create a class template before creating a class"
      redirect_to new_class_template_path
    end
    @clazz = Clazz.new
  end

  def edit
  end

  def create
    @clazz = profile.classes.build create_params
    if @clazz.save
      flash[:success] = "Class created"
      redirect_to classes_path
    else
      flash[:danger] = "Unable to create class"
      render :new
    end
  end

  def update
    if @clazz.update_attributes create_params
      flash[:success] = "Class saved"
      redirect_to classes_path
    else
      flash[:danger] = "Unable to save class"
      render :edit
    end
  end

  private

  def find_class
    @clazz = Clazz.find_by id: params[:id]
    if @clazz.nil?
      flash[:danger] = "Unable to find class"
      redirect_to root_path
    end
  end

  def owns_class
    unless current_user.id == @clazz.instructor_profile.user_id
      flash[:danger] = "Unauthorized access"
      redirect_to root_path
    end
  end

  def create_params
    params.require(:clazz).permit(Clazz::PERMITTED_PARAMS)
  end

  def profile
    current_user.instructor_profile
  end
end
