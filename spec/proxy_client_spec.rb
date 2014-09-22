require 'spec_helper'
require 'rack/test'

describe RspecApiDocumentation::ProxyClient do
  let(:context) { |example| double(:example => example) }
  let(:test_client) { RspecApiDocumentation::ProxyClient.new(context, {}) }
  subject { test_client }

  it { expect(subject).to be_a(RspecApiDocumentation::ProxyClient) }

  describe "something" do
    it 'should contain the query_string' do
      test_client.get "/v1/sites.json"
      puts 
    end
  end
end
