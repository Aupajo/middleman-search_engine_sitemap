require 'middleman/rack'
require 'rack/test'

module MiddlemanServerHelpers
  include Rack::Test::Methods

  def app
    @app.call
  end

  def visit(path)
    get(path)
    expect(last_response.status).to eql(200),
      "Expected 200 response, got #{last_response.status}: #{last_response.body}"
  end

  def find_on_page(string)
    expect(last_response.body).to include(string)
  end

  def run_site(path, &block)
    setup_environment(path)

    @app = lambda do
      instance = Middleman::Application.server.inst do
        # Require the pagination extension after the
        # server has booted, as would typically happen.
        require File.expand_path('../../../lib/middleman_extension', __FILE__)

        instance_exec(&block)
      end

      instance.class.to_rack_app
    end
  end

  private

  def setup_environment(path)
    ENV['MM_ROOT'] = File.expand_path("../../#{path}", __FILE__)
    ENV['TEST'] = "true"
  end
end