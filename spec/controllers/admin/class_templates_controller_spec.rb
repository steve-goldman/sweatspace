require "rails_helper"

RSpec.describe Admin::ClassTemplatesController, type: :controller do
  render_views
  before { login_admin_user }

  let(:instance) { FactoryGirl.create :class_template }
  it_behaves_like "a creatable resource"
  it_behaves_like "an updatable resource"
end
