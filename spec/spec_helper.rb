require "rack/test"
require "rspec"
require "rswag/specs"

ENV["RACK_ENV"] = "test"

require File.expand_path "../../app.rb", __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app
    App
  end
end

# For RSpec 2.x and 3.x
RSpec.configure { |c|
  c.include RSpecMixin

  c.add_setting :swagger_root
  c.add_setting :swagger_docs
  c.add_setting :swagger_dry_run
  c.add_setting :swagger_format
  c.extend Rswag::Specs::ExampleGroupHelpers
  c.include Rswag::Specs::ExampleHelpers

  c.swagger_root = "swagger"
  c.swagger_dry_run = false

  c.swagger_docs = {
    "v1/swagger.json" => {
      openapi: "3.0.1",
      info: {
        title: "API V1",
        version: "v1"
      },
      paths: {},
      servers: [
        {
          url: "https://{defaultHost}",
          variables: {
            defaultHost: {
              default: "www.example.com"
            }
          }
        }
      ],
      components: {
        schemas: {
          Pet: {
            allOf: [
              {
                "$ref" => "#/components/schemas/NewPet"
              },
              {
                type: "object",
                properties: {
                  id: {
                    type: "integer",
                    format: "int64"
                  }
                },
                required: ["id"]
              }
            ]
          },
          NewPet: {
            type: "object",
            properties: {
              name: {
                type: "string"
              },
              tag: {
                type: "string"
              }
            },
            required: ["name"]
          },
          Error: {
            type: "object",
            properties: {
              code: {
                type: "integer",
                format: "int32"
              },
              message: {
                type: "string"
              }
            },
            required: ["code", "message"]
          }
        }
      }
    }
  }
}
