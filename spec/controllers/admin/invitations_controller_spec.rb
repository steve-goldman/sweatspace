require "rails_helper"

RSpec.describe Admin::InvitationsController, type: :controller do
  render_views
  before { login_admin_user }

  it_behaves_like "an indexable resource"
  it_behaves_like "a newable resource"
  it_behaves_like "a creatable resource", Invitation, {}
end
