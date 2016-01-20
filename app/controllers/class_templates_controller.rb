class ClassTemplatesController < ApplicationController
  before_action :find_class_template, only: [:edit, :update]
  before_action :owns_class_template, only: [:edit, :update]

  def index
    @class_templates = profile.class_templates.decorate
  end

  def new
    @class_template = ClassTemplate.new
  end

  def edit
  end

  def create
    @class_template = profile.class_templates.build create_params
    if @class_template.save
      flash[:success] = "Class template created"
      redirect_to class_templates_path
    else
      flash[:danger] = "Unable to create class template"
      render :new
    end
  end

  def update
    if @class_template.update_attributes create_params
      flash[:success] = "Class saved"
      redirect_to class_templates_path
    else
      flash[:danger] = "Unable to save class template"
      render :edit
    end
  end

  private

  def find_class_template
    @class_template = ClassTemplate.find_by id: params[:id]
    if @class_template.nil?
      flash[:danger] = "Unable to find class template"
      redirect_to root_path
    end
  end

  def owns_class_template
    unless current_user.id == @class_template.instructor_profile.user_id
      flash[:danger] = "Unauthorized access"
      redirect_to root_path
    end
  end

  def create_params
    params.require(:class_template).permit(ClassTemplate::PERMITTED_PARAMS)
  end

  def profile
    current_user.instructor_profile
  end
end
