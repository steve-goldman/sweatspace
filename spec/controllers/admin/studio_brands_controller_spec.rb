require "rails_helper"

RSpec.describe Admin::StudioBrandsController, type: :controller do
  render_views
  before { login_admin_user }

  it_behaves_like "an indexable resource"
  it_behaves_like "a newable resource"
  it_behaves_like "a creatable resource", StudioBrand, {}
  it_behaves_like "an editable resource", StudioBrand
  it_behaves_like "an updatable resource", StudioBrand,
                  success_path: :admin_studio_brands_path
end
