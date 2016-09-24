require 'unit_4_multivers/account'
require 'unit_4_multivers/administration'
require 'unit_4_multivers/customer'
require 'unit_4_multivers/department'
require 'unit_4_multivers/journal'
require 'unit_4_multivers/product'
require 'unit_4_multivers/project'
require 'unit_4_multivers/openingbalance'
require 'unit_4_multivers/supplier'
require 'unit_4_multivers/version'

module Unit4Multivers
  class Client
    API_VERSION = 'V18'
    # Sets or gets the api_version to be used in API calls
    #
    # @return [String]
    attr_accessor :api_version
    attr_accessor :oauth_client

    # Sets or gets the division id to be used in API calls
    #
    # @return [String]
    # attr_accessor :division_id, :database_name

    def initialize(oauth_client, opts = {})
      @oauth_client = oauth_client
      @api_version = API_VERSION
    end

    # Make a custom request
    def custom_request(uri, opts = {})
      get uri, opts
    end

    def check_required_parameters(required, params)
      params.fetch(required) { raise ArgumentError, "Missing required parameters: #{required - params.keys}" if (required-params.keys).size > 0 }
    end

    private

    def get(path, headers = {})
      begin
        @oauth_client.refresh_token! if @oauth_client.access_token.expired?
        res = extract_response_body raw_get(path, headers)
      rescue
        @oauth_client.refresh_token!
        res = extract_response_body raw_get(path, headers)
      end
    end

    def raw_get(path, headers = {})
      headers.merge!(headers: { 'User-Agent' => 'Unit4Multivers gem',
             'Accept' => 'application/json' })

      @oauth_client.access_token.get("api#{path}", headers)
    end

    def post(path, body = '', headers = {})
      extract_response_body raw_post(path, body, headers)
    end

    def raw_post(path, body = '', headers = {})
      headers.merge!(headers: { 'User-Agent' => 'Unit4Multivers gem' })
      @oauth_client.access_token.post("api#{path}", body, headers)
    end

    def delete(path, headers = {})
      extract_response_body raw_delete(path, headers)
    end

    def raw_delete(path, headers = {})
      headers.merge!(headers: { 'User-Agent' => 'Unit4Multivers gem' })
      @oauth_client.access_token.delete("api#{path}", headers)
    end

    def extract_response_body(resp)
      resp.nil? || resp.body.nil? ? {} : JSON.parse(resp.body)
    end
  end
end
