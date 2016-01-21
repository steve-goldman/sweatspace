require "rails_helper"

RSpec.describe Admin::ClazzTypesController, type: :controller do
  render_views
  before { login_admin_user }

  let(:instance) { FactoryGirl.create :clazz_type }
  it_behaves_like "a creatable resource"
  it_behaves_like "an updatable resource"
end
