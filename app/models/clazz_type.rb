class ClazzType < ActiveRecord::Base
  PERMITTED_PARAMS = [
    "name"
  ]

  validates_presence_of :name
  validates_uniqueness_of :name
  has_paper_trail
end
