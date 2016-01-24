require "rails_helper"

RSpec.describe Admin::ClassTemplatesController, type: :controller do
  render_views
  before { login_admin_user }

  it_behaves_like "an indexable resource"
  it_behaves_like "a newable resource"
  it_behaves_like "a creatable resource", ClassTemplate, {}
  it_behaves_like "an editable resource", ClassTemplate
  it_behaves_like "an updatable resource", ClassTemplate,
                  success_path: :admin_class_templates_path
end
