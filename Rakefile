task default: %w[swaggerize]

task :swaggerize do
  sh "bundle exec rspec --format Rswag::Specs::SwaggerFormatter --require spec_helper"
end
