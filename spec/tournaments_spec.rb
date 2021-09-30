require 'spec_helper'

RSpec.describe "Tournament Endpoints" do
  before(:each) do
    @client = ChallongeUserRails::Client.new(api_key: "Bu1jqfn2whgYiS2uOeD4iiTf25P2amiyuxLhHMKZ")
  end

  it "Fetches all Tournaments" do
    response = @client.tournaments
    expect(response[:code]).to eq(200)
  end

  it "Fetches a specific Tournament" do
    response = @client.tournament("idctcvg1")
    expect(response[:code]).to eq(200)
  end

  it "Returns proper Error Hash when fetching a tournament" do
    response = @client.tournament("errorIDTournament")
    expect(response[:code]).to eq(404)
  end

end
