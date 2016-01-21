require "rails_helper"

RSpec.describe Admin::StudiosController, type: :controller do
  render_views
  before { login_admin_user }

  let(:instance) { FactoryGirl.create :studio }
  it_behaves_like "a creatable resource"
  it_behaves_like "an updatable resource"
end
