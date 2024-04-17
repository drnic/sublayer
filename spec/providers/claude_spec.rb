require "spec_helper"

RSpec.describe Sublayer::Providers::Claude do
  before do
    Sublayer.configuration.ai_provider = described_class
    Sublayer.configuration.ai_model = "claude-3-haiku-20240307"
  end

  describe "#call" do
    it "calls the Claude API" do
      VCR.use_cassette("claude/42") do
        output_adapter = Sublayer::Components::OutputAdapters.create(
          type: :single_string,
          name: "claude_response",
          description: "The response from Claude"
        )
        response = described_class.call(
          prompt: "What is the meaning of life? Give it to me as a number.",
          output_adapter: output_adapter
        )

        expect(response).to eq("42")
      end
    end
  end
end
