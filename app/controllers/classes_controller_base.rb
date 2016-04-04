class ClassesControllerBase < ApplicationController
  before_action :user_signed_in, except: :show
  before_action :user_has_profile, except: :show
  before_action :set_back_link, except: :show

  private
  
  def class_template_options studio
    StudioClassTemplateService.instance.class_templates_by_studio(studio).map do |class_template|
      [class_template.name, class_template.id]
    end
  end

  helper_method :class_template_options

  def set_back_link
    NavbarConfig.instance.back_link = profile_path current_user.instructor_profile.profile_path
  end
end
