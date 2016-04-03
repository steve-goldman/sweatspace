class StudioBrandStudio < ActiveRecord::Base
    PERMITTED_PARAMS = [
    "studio_brand_id",
    "studio_id",
  ]

  acts_as_paranoid
  has_paper_trail

  belongs_to :studio_brand
  belongs_to :studio
  validates_presence_of :studio_brand_id, :studio_id
end
