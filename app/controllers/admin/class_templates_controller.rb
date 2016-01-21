class Admin::ClassTemplatesController < Admin::ControllerBase
  before_action :find_class_template, only: [:edit, :update]

  def index
    @class_templates = ClassTemplate.all.decorate
  end

  def new
    @class_template = ClassTemplate.new
  end

  def edit
  end

  def create
    @class_template = ClassTemplate.new create_params
    if @class_template.save
      flash[:success] = "Class template created"
      redirect_to admin_class_templates_path
    else
      flash[:danger] = "Unable to create class template"
      render :new
    end
  end

  def update
    if @class_template.update_attributes create_params
      flash[:success] = "Class template saved"
      redirect_to admin_class_templates_path
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

  def create_params
    params.require(:class_template).permit(ClassTemplate::PERMITTED_PARAMS)
  end
end
