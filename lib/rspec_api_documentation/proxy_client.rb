require 'httpclient'
require 'uri'

module RspecApiDocumentation
  class ProxyClient < ClientBase
    attr_accessor :last_response, :last_request
    private :last_response, :last_request

    def request_headers
      {}
    end

    def response_headers
      last_response.headers
    end

    def query_string
      ""
    end

    def status
      last_response.status
    end

    def response_body
      last_response.body
    end

    def request_content_type
      last_request.content_type
    end

    def response_content_type
      last_response.content_type
    end

    protected

    def do_request(method, path, params, request_headers)
      raise "SUT_URL NOT SET" unless ENV['SUT_URL']
      uri = "#{ENV['SUT_URL'].chomp('/')}#{path}"
      if ENV['HTTP_USERNAME'] && ENV['HTTP_PASSWORD']
        @http_client.set_auth(ENV['SUT_URL'], ENV['HTTP_USERNAME'], ENV['HTTP_PASSWORD'])
      end
      puts "SETTING LAST REQUEST"
      self.last_request = OpenStruct.new(:env => {'rack.input' => StringIO.new("this should be the request body")})
      self.last_response = http_client.request(method, uri, params, body = nil, request_headers)
    end

    private
    def http_client
      @http_client ||= HTTPClient.new
    end
  end
end
