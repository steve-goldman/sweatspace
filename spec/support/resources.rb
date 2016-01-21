shared_examples "a creatable resource" do
  describe "GET :new" do
    it "renders the view" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST :create" do
  end
end

shared_examples "an updatable resource" do
  describe "GET :edit" do
    it "renders the view" do
      get :edit, id: instance.id
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH :update" do
  end
end
