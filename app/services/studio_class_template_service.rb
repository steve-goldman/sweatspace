class StudioClassTemplateService
  include Singleton

  def class_templates_by_studio studio
    if studio
      ClassTemplate.where(studio_brand_id: studio.studio_brands).order(name: :asc)
    else
      []
    end
  end
end
