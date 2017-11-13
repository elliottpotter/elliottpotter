require 'net/http'

# Service for making API requests
class APIService
  def initialize(url)
    @url = url
  end

  def build_http(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true # this will cause a Puma::HttpParserError when pointed at local server
    http.open_timeout = 10 # seconds
    http.read_timeout = 10 # seconds

    http
  end

  def post_request(headers = {}, params = nil)
    make_request("post", headers, params)
  end

  def make_request(verb, headers = {}, params = {}) # verb should be a string
    begin
      uri = URI(@url)
      req_class = "Net::HTTP::#{verb.classify}".constantize
      req = req_class.new(uri)
      req.body = params if params.is_a? String
      req.body ||= params.to_json
      headers.each { |k, v| req[k] = v } # set the headers
      http = build_http(uri)

      http.request(req)
    end
  end
end
