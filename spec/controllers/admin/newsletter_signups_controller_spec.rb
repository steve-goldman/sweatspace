require "rails_helper"

RSpec.describe Admin::NewsletterSignupsController, type: :controller do
  render_views
  before { login_admin_user }

  it_behaves_like "an indexable resource"
end
