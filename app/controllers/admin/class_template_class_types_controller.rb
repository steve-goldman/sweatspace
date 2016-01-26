class Admin::ClassTemplateClassTypesController < Admin::ControllerBase
  before_action :find_class_template_class_type, only: :destroy

  def create
    class_template_class_type = ClassTemplateClassType.create! create_params
    redirect_to request.referer || edit_admin_class_template_path(class_template_class_type.class_template)
  end

  def destroy
    @class_template_class_type.destroy!
    redirect_to request.referer || edit_admin_class_template_path(@class_template_class_type.class_template)
  end

  private

  def find_class_template_class_type
    @class_template_class_type = ClassTemplateClassType.find_by id: params[:id]
    if @class_template_class_type.nil?
      flash[:danger] = "Could not find class template class type"
      redirect_to request.referer
    end
  end

  def create_params
    params.require(:class_template_class_type).permit(ClassTemplateClassType::PERMITTED_PARAMS)
  end
end
