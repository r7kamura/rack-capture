# frozen_string_literal: true

require 'pathname'
require 'rack'
require 'rack/capture/version'

module Rack
  class Capture
    class << self
      # @param [#call] app Rack application.
      # @param [String] url
      def call(
        app:,
        url:
      )
        new(app: app, url: url).call
      end
    end

    # @param [#call] app Rack application.
    # @param [String] url
    def initialize(
      app:,
      url:
    )
      @app = app
      @url = url
    end

    def call
      response = get_response
      destination = calculate_destination(response: response)
      destination.parent.mkpath
      content = ''
      response.body.each do |element|
        content << element
      end
      destination.write(content)
    end

    private

    # @param [Rack::Response] response
    def calculate_destination(response:)
      destination = ::Pathname.new("dist#{uri.path}")
      if response.content_type&.include?('text/html')
        destination += 'index' if uri.path == '/'
        destination = destination.sub_ext('.html')
      end
      destination
    end

    # @return [Rack::Response]
    def get_response
      status, headers, body = @app.call(rack_env)
      ::Rack::Response.new(body, status, headers)
    end

    # @return [Hash]
    def rack_env
      {
        'HTTP_HOST' => @host,
        'PATH_INFO' => uri.path,
        'QUERY_STRING' => uri.query || '',
        'rack.url_scheme' => rack_url_scheme,
        'REQUEST_METHOD' => 'GET',
        'SCRIPT_NAME' => '',
        'SERVER_NAME' => uri.host
      }
    end

    # @return [String]
    def rack_url_scheme
      if uri.scheme == 'https'
        'https'
      else
        'http'
      end
    end

    # @return [URI]
    def uri
      @uri ||= ::URI.parse(@url)
    end
  end
end
