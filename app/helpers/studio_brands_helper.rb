module StudioBrandsHelper
  def studio_brand_options
    make_studio_brand_options all_studio_brands
  end

  def not_studio_studio_brand_options studio
    make_studio_brand_options (all_studio_brands - studio.studio_brands)
  end

  private

  def all_studio_brands
    StudioBrand.all.order name: :asc
  end

  def make_studio_brand_options studio_brands
    studio_brands.map do |studio_brand|
      [studio_brand.name, studio_brand.id]
    end
  end
end
