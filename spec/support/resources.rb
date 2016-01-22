shared_examples "an indexable resource" do
  it "renders the view" do
    get :index
    expect(response).to render_template(:index)
  end
end
  
shared_examples "a showable resource" do |klass, options|
  let(:symbolized_class) { klass.name.underscore.to_sym }
  let!(:resource) { FactoryGirl.create symbolized_class }

  describe "GET :show" do
    it "renders the view" do
      get :show, id: resource.send(options[:id_field])
      expect(response).to render_template(:show)
    end
  end
end

shared_examples "a newable resource" do
  describe "GET :new" do
    it "renders the view" do
      get :new
      expect(response).to render_template(:new)
    end
  end
end

shared_examples "a creatable resource" do |klass, options|
  let(:symbolized_class) { klass.name.underscore.to_sym }
  let(:attributes) { FactoryGirl.build(symbolized_class).attributes }

  describe "POST :create" do
    context "SUCCESS" do
      def do_action
        post :create, symbolized_class => attributes
      end

      if options.has_key? :success_path
        it "redirects on success" do
          do_action
          expect(response).to redirect_to(send(options[:success_path]))
        end
      end

      it "creates a database record" do
        expect { do_action }.to change { klass.count }.by(1)
      end
    end

    context "FAILURE" do
      def do_action
        post :create, symbolized_class => { bogus_key: "bogus-value" }
      end

      it "renders" do
        do_action
        expect(response).to render_template(:new)
      end

      it "does not create a database record" do
        expect { do_action }.to_not change { klass.count }
      end
    end
  end
end

shared_examples "an editable resource" do |klass, options = nil|
  let(:symbolized_class) { klass.name.underscore.to_sym }
  let!(:resource) { FactoryGirl.create symbolized_class }

  describe "GET :edit" do
    (options.try(:[], :before_actions) || []).each do |before_action|
      before { allow_any_instance_of(described_class).to receive(before_action) }
    end

    def do_action
      get :edit, id: resource.id
    end

    it "renders the view" do
      get :edit, id: resource.id
      expect(response).to render_template(:edit)
    end
  end
end

shared_examples "an updatable resource" do |klass, options|
  let(:symbolized_class) { klass.name.underscore.to_sym }
  let!(:resource) { FactoryGirl.create symbolized_class }

  describe "PATCH :update" do
    (options[:before_actions] || []).each do |before_action|
      before { allow_any_instance_of(described_class).to receive(before_action) }
    end

    def do_action
      patch :update, id: resource.id, symbolized_class => resource.attributes
    end

    context "SUCCESS" do
      if options.has_key? :success_path
        it "redirects on success" do
          do_action
          expect(response).to redirect_to(send(options[:success_path]))
        end
      end
    end

    context "FAILURE" do
      let(:empty_hash) do
        resource.attributes.each_with_object({}) do |(key, value), hash|
          hash[key] = nil
        end
      end

      it "renders" do
        patch :update, id: resource.id, symbolized_class => empty_hash
        expect(response).to render_template(:edit)
      end
    end
  end
end

shared_examples "a destroyable resource" do |klass, options|
  let(:symbolized_class) { klass.name.underscore.to_sym }
  let!(:resource) { FactoryGirl.create symbolized_class }

  describe "DELETE :destroy" do
    def do_action
      delete :destroy, id: resource.id
    end

    context "SUCCESS" do
    end

    context "FAILURE" do
    end
  end
end
