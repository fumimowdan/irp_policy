require_relative "lib/irp/version"

Gem::Specification.new do |spec|
  spec.name        = "irp"
  spec.version     = Irp::VERSION
  spec.authors     = ["fumimowdan"]
  spec.email       = ["tecknuovo@zemis.co.uk"]
  spec.homepage    = "http://irp.gov.uk"
  spec.summary     = "Summary of Irp."
  spec.description = "Description of Irp."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://git.scm/irp"
  spec.metadata["changelog_uri"] = "https://git.scm/irp/chancelog"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.4"
  spec.add_dependency "govuk-components", "4.1.1"
  spec.add_dependency "govuk_design_system_formbuilder"
  spec.add_dependency "phonelib"
  spec.add_dependency "uk_postcode"
  spec.add_dependency "rubyXL", "~> 3.4"

  spec.add_development_dependency "rspec-rails"
end
