# frozen_string_literal: true

require 'pp' # Must be called before fakefs.
require 'fakefs/spec_helpers'
require 'json'
require 'pathname'

RSpec.describe Rack::Capture do
  describe '.call' do
    include FakeFS::SpecHelpers

    subject do
      described_class.call(
        app: app,
        url: url
      )
    end

    let(:app) do
      lambda { |_env|
        [
          200,
          { 'Content-Type' => 'text/html' },
          %w[]
        ]
      }
    end

    context 'with GET /index.html' do
      let(:url) do
        'http://example.com/'
      end

      it 'creates dist/index.html' do
        subject
        pathname = Pathname.new('dist/index.html')
        expect(pathname).to exist
      end
    end

    context 'with GET /' do
      let(:url) do
        'http://example.com/'
      end

      it 'creates dist/index.html' do
        subject
        pathname = Pathname.new('dist/index.html')
        expect(pathname).to exist
      end
    end
  end
end
