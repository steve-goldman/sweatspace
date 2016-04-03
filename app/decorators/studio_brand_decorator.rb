class StudioBrandDecorator < Draper::Decorator
  delegate_all
  decorates_association :studio_brand_studios
end
