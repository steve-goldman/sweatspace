class StudioBrandStudioDecorator < Draper::Decorator
  delegate_all
  decorates_association :studio_brand
  decorates_association :studio

  def studio_brand_name
    studio_brand.name
  end

  def studio_full_name
    studio.full_name
  end
end
