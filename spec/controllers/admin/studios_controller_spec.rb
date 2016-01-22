require "rails_helper"

RSpec.describe Admin::StudiosController, type: :controller do
  render_views
  before { login_admin_user }

  it_behaves_like "an indexable resource"
  it_behaves_like "a newable resource"
  it_behaves_like "a creatable resource", Studio,
                  success_path: :admin_studios_path
  it_behaves_like "an editable resource", Studio
  it_behaves_like "an updatable resource", Studio,
                  success_path: :admin_studios_path
end
