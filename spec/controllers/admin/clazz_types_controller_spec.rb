require "rails_helper"

RSpec.describe Admin::ClazzTypesController, type: :controller do
  render_views
  before { login_admin_user }

  it_behaves_like "an indexable resource"
  it_behaves_like "a newable resource"
  it_behaves_like "a creatable resource", ClazzType,
                  success_path: :admin_class_types_path
  it_behaves_like "an editable resource", ClazzType
  it_behaves_like "an updatable resource", ClazzType,
                  success_path: :admin_class_types_path
end
