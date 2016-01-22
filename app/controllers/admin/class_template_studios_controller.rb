class Admin::ClassTemplateStudiosController < Admin::ControllerBase
  before_action :find_class_template_studio, only: :destroy

  def create
    class_template_studio = ClassTemplateStudio.create! create_params
    redirect_to edit_admin_class_template_path(class_template_studio.class_template)
  end

  def destroy
    @class_template_studio.destroy!
    redirect_to edit_admin_class_template_path(@class_template_studio.class_template)
  end

  private

  def find_class_template_studio
    @class_template_studio = ClassTemplateStudio.find_by id: params[:id]
    if @class_template_studio.nil?
      flash[:danger] = "Could not find class template studio"
      redirect_to request.referer
    end
  end

  def create_params
    params.require(:class_template_studio).permit(ClassTemplateStudio::PERMITTED_PARAMS)
  end
end