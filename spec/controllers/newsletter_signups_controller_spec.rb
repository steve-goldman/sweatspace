require "rails_helper"

RSpec.describe NewsletterSignupsController, type: :controller do
  render_views

  it_behaves_like "a newable resource"
  it_behaves_like "a creatable resource", NewsletterSignup, {}
end
