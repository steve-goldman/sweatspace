class DurationByClassTemplateController < ApplicationController
  before_action :find_class_template

  def show
    @duration = @class_template.try :duration
  end

  private

  def find_class_template
    @class_template = ClassTemplate.find_by id: params[:class_template_id]
  end
end
