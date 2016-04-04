class ClassTemplatesByStudioController < ApplicationController
  before_action :find_studio

  def show
    @class_templates = StudioClassTemplateService.instance.class_templates_by_studio @studio
  end

  private

  def find_studio
    @studio = Studio.find_by id: params[:studio_id]
  end
end
