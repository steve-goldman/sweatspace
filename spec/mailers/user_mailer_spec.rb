require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe ".invited" do
    let(:address) { "example@email.com" }
    let(:token) { UUIDTools::UUID.random_create.to_s }
    let(:mail) { described_class.invited(address, token) }

    it "sends to the address" do
      expect(mail.to).to eq([address])
    end
  end
end
