require 'spec_helper'

RSpec.describe "Matches Endpoints" do
  before(:each) do
    @client = ChallongeUserRails::Client.new(api_key: "Bu1jqfn2whgYiS2uOeD4iiTf25P2amiyuxLhHMKZ")
  end

  it "Fetches all matches of a specific Tournament" do
    response = @client.matches("idctcvg1")
    expect(response[:code]).to eq(200)
  end

  it "Returns proper Error Hash when fetching all matches of a tournament" do
    response = @client.matches("errorIDTournament")
    expect(response[:code]).to eq(404)
  end

  it "Fetches specific match of a specific Tournament" do
    response = @client.match("idctcvg1", 245843349)
    expect(response[:code]).to eq(200)
  end

  it "Returns proper Error Hash when fetching specific matches of a tournament" do
    response = @client.match("errorIDTournament", 245843312312)
    expect(response[:code]).to eq(404)
  end

end
