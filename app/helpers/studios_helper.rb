module StudiosHelper
  def studio_options
    make_studio_options all_studios
  end

  def not_studio_brand_studio_options studio_brand
    make_studio_options(all_studios - studio_brand.studios)
  end

  private

  def all_studios
    Studio.all.order name: :asc, site: :asc
  end

  def make_studio_options studios
    studios.map do |studio|
      label = studio.name
      label = "#{label} #{studio.site}" if studio.site
      [label, studio.id]
    end
  end
end
