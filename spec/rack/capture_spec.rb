# frozen_string_literal: true

require 'pp' # Must be called before fakefs.
require 'fakefs/spec_helpers'
require 'json'

RSpec.describe Rack::Capture do
  describe '.call' do
    include FakeFS::SpecHelpers

    subject do
      described_class.call(**kwargs)
    end

    let(:app) do
      lambda { |env|
        request = Rack::Request.new(env)
        [
          200,
          { 'Content-Type' => 'text/html' },
          [
            {
              'path' => request.path,
              'path_info' => request.path_info,
              'script_name' => request.script_name
            }.to_json
          ]
        ]
      }
    end

    let(:kwargs) do
      {
        app: app,
        url: url
      }
    end

    let(:url) do
      'http://example.com/index.html'
    end

    context 'with GET /index.html' do
      it 'creates dist/index.html' do
        subject
        content = File.read('dist/index.html')
        hash = JSON.parse(content)
        expect(hash).to eq(
          'path' => '/index.html',
          'path_info' => '/index.html',
          'script_name' => ''
        )
      end
    end

    context 'with GET /' do
      let(:url) do
        'http://example.com/'
      end

      it 'creates dist/index.html' do
        subject
        content = File.read('dist/index.html')
        hash = JSON.parse(content)
        expect(hash).to eq(
          'path' => '/',
          'path_info' => '/',
          'script_name' => ''
        )
      end
    end

    context 'with script_name option' do
      let(:kwargs) do
        super().merge(script_name: '/a')
      end

      it 'uses it as SCRIPT_NAME' do
        subject
        content = File.read('dist/index.html')
        hash = JSON.parse(content)
        expect(hash).to eq(
          'path' => '/a/index.html',
          'path_info' => '/index.html',
          'script_name' => '/a'
        )
      end
    end

    context 'with output_directory_path option' do
      let(:kwargs) do
        super().merge(output_directory_path: 'a/b')
      end

      it 'uses it as output directory path' do
        subject
        expect(File).to be_file('a/b/index.html')
      end
    end
  end
end
