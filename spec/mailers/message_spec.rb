require "rails_helper"

RSpec.describe MessageMailer, type: :mailer do
  describe "new_response" do

    let(:mail) { MessageMailer.new_response }

    it "renders the headers" do
      # expect(mail.subject).to eq("Hello")
      # expect(mail.to).to eq(["to@example.org"])
      # expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      # expect(mail.body.encoded).to match("Hi")
    end
  end

end
